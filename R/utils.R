#' Set CBBD API key
#'
#' @description Sets the API key for a user to interface with the College Basketball Data API. Will prompt interactively if no key is passed in as a function argument. For more details about getting an API key, see https://collegebasketballdata.com/key.
#'
#' @param key An API key for interfacing with the College Basketball Data API, as a string. Should not include "Bearer " in front of the key.
#'
#' @export
#' @examples
#' \donttest{
#' try(set_api_key())
#' }
set_api_key <- function() {
  cli::cli_alert_info(
    "Please input your CBBD API key for persistent storage. To get an API key for free, please sign up here: https://collegebasketballdata.com/key"
  )
  keyring::key_set("CBBD_API_KEY")
}

#' Handle error messages from CBBD API calls
#'
#' @param resp an API response from the CBBD API
#'
#' @return A string containing the message from a response from the CBBD API
#' @noRd
#' @keywords internal
message_body <- function(resp) {
  if (httr2::resp_body_json(resp)$message == "Unauthorized") {
    msg <- "You are not authorized to access this endpoint. This error typically arises from your API key being invalid. Please ensure your API key is set correctly with `cbbdr::set_api_key()`."
  } else {
    msg <- resp |>
      httr2::resp_body_json() |>
      _$message
  }
  return(msg)
}

#' Query the College Basketball Data API
#'
#' @description A low level function used to query the College Basketball Data API. For a given `endpoint` and an optional `query` list, returns the results of an API call in list format.
#'
#' It is advised that `cbbdr` users instead use `get_*` functions when available, as this function returns raw, unformatted data, and `get_*` functions return cleaned data. It can be used to query new endpoints that do not have currently implemented `get_*` functions available.
#'
#' @param endpoint A valid CBBD API endpoint, such as `venues`
#' @param query A named list of parameters with which to query the endpoint, such as `list(season = 2025)`. When wishing to query an endpoint without parameters, use an empty list. Defaults to an empty list.
#'
#' @returns The data from an API endpoint call, formatted as a list.
#'
#' @export
#' @examples
#' \donttest{
#' try({
#'   query_cbbd("venues")
#'   query_cbbd("teams", query = list(conference = "ACC", season = 2024))
#' })
#' }
query_cbbd <- function(endpoint, query = list()) {
  # check that CBBD_API_KEY is set, if not, prompt user to set it and obtain key
  if (!("CBBD_API_KEY" %in% keyring::key_list()$service)) {
    cli::cli_abort(c(
      "Must provide an API key:",
      "i" = "In order to use this package, you must obtain a free API key from https://collegebasketballdata.com/key and then set the key using `cbbdr::set_api_key()`.",
      "x" = "No CBBD API key was found on your system."
    ))
  }
  resp <- httr2::request("https://api.collegebasketballdata.com") |>
    httr2::req_url_path_append(endpoint) |>
    httr2::req_url_query(!!!query) |>
    httr2::req_method("GET") |>
    httr2::req_headers(
      accept = "application/json",
      Authorization = paste("Bearer", keyring::key_get("CBBD_API_KEY"))
      # Authorization = "foobar"
    ) |>
    httr2::req_error(body = message_body) |>
    httr2::req_timeout(60) |>
    httr2::req_perform()
  if (httr2::resp_content_type(resp) != "application/json") {
    cli::cli_abort(
      "Response returned was not json. This typically happens when querying an endpoint that does not exist. Please ensure you have passed in a valid endpoint. See the CBBD API docs here: https://api.collegebasketballdata.com/"
    )
  }
  df <- resp |>
    httr2::resp_body_raw() |>
    RcppSimdJson::fparse()
  if (!is.null(df)) {
    df <- janitor::clean_names(df)
  } else {
    df <- data.frame()
  }
  return(df)
}

#' get the most recent CBB season
#'
#' @description For a given date (defaults to the system date), returns the most recent or "current" college basketball season.
#'
#' @param date the date to obtain the most recent season of. Defaults to the system date.
#'
#' @return the most recent CBB season as an integer
#'
#' @examples
#' \donttest{
#' most_recent_season()
#'
#' most_recent_season("2022-09-01") # up to september, will be recorded as 2022
#'
#' most_recent_season("2022-10-01") # then will swap over to 2023 when we hit october
#' }
#'
#' @export
most_recent_season <- function(date = Sys.Date()) {
  date <- as.Date(date)
  if (as.integer(format(date, "%m")) < 10) {
    return(as.integer(format(date, "%Y")))
  } else {
    return(as.integer(format(date, "%Y")) + 1)
  }
}

#' helper function to ensure that seasons passed into load_* functions are available
#'
#' @description The data coverage for years of data can be wildly variable. To handle checking available years of data, this internal function will throw an error if the values passed into `seasons` do not fall between the first and second arguments.
#'
#' @return nothing or an error if any values in `seasons` are outside of `first_season:last_season`
#' @noRd
#' @keywords internal
check_seasons_legit <- function(
  seasons,
  first_season = 2003,
  last_season = most_recent_season()
) {
  if (isTRUE(seasons)) {
    seasons <- first_season:last_season
  }
  stopifnot(
    is.numeric(seasons),
    seasons >= first_season,
    seasons <= last_season
  )
  return(seasons)
}

#' Clean game type identifier
#'
#' @description Internal function for cleaning up the game type identifier to be consistent across all seasons.
#'
#' @param x A dataframe that has a `game_type` column.
#'
#' @returns The same dataframe with the `game_type` column cleaned such that all values are either `STD`, `TRNMNT`, or `NA`
#' @noRd
#' @keywords internal
clean_game_type <- function(x) {
  data.table::setDT(x)
  x[
    ,
    game_type := data.table::fcase(
      game_type == "STD",
      "STD",
      data.table::`%chin%`(game_type, c("FINAL", "QTR", "RD16", "RD32", "RD64", "SEMI", "TRNMNT")),
      "TRNMNT",
      default = NA_character_
    )
  ]
}

#' Convert % as a string into a decimal
#'
#' @description An internal function. The CBBD API will sometimes return percentages formatted as "30.2" instead of "0.302". This function converts them into a numerically consistent format.
#'
#' @param x A dataframe with columns to be converted to percentages.
#' @param pct_cols A vector of column names to be converted to percentages. No checking is done to ensure that these columns do or do not exist in the dataframe, as this is an internal function.
#'
#' @returns The same dataframe with specified columns converted to decimals from the percentage format.
#' @noRd
#' @keywords internal
pct_to_decimal <- function(
  x,
  pct_cols = c(
    "usage",
    "effective_field_goal_pct",
    "true_shooting_pct",
    "free_throw_rate",
    "offensive_rebound_pct",
    "field_goals_pct",
    "two_point_field_goals_pct",
    "three_point_field_goals_ct",
    "free_throws_pct"
  )
) {
  data.table::setDT(x)
  cols <- lapply(pct_cols, \(y) colnames(x)[grepl(y, colnames(x))]) |>
    unlist() |>
    unique()
  for (col in cols) {
    x[, (col) := get(col) / 100]
  }
}

#' Internal function for querying response-restricted endpoints intelligently.
#'
#' @description An internal function for querying endpoints of the CBBD API that will return only the first X records.
#'
#' @param my_path A string, referencing the endpoint to query.
#' @param query_season An integer, referencing the season to query. Defaults to the most recent season.
#' @param game_identifier A string with the column name that refers to each game's unique identifier. Defaults to `game_id`
#' @param max_results_returned An integer, indicating the maximum number of results returned by the endpoint. Defaults to `3000`.
#'
#' @returns All records from the queried path.
#' @noRd
#' @keywords internal
query_games <- function(
  my_path,
  query_season = most_recent_season(),
  game_identifier = "game_id",
  max_results_returned = 3000
) {
  start_date <- as.Date(paste0(query_season - 1, "-10-01"))
  end_date <- as.Date(paste0(query_season, "-05-01"))
  dfs <- list()
  counter <- 0
  while (start_date < end_date) {
    counter <- counter + 1
    tmp_df <- query_cbbd(
      my_path,
      list(
        startDateRange = start_date,
        endDateRange = end_date
      )
    )
    dfs[[counter]] <- tmp_df
    if (nrow(tmp_df) == max_results_returned) {
      start_date <- max(as.Date(tmp_df$start_date))
    } else {
      start_date <- end_date
    }
  }
  dfs |>
    data.table::rbindlist() |>
    unique(by = game_identifier)
}

#' Check if dates are in proper format
#'
#' @description an internal function to verify that a provided value is in ISO 8601 (YYYY-MM-DD) format.
#'
#' @param x a date to check
#'
#' @returns true if in ISO 8601 format, false if not.
#'
#' @noRd
#' @keywords internal
is_iso_8601 <- function(x) {
  !is.na(as.Date(x, format = "%Y-%m-%d"))
}

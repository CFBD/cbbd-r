#' get_plays_by_date
#'
#' @description Retrieve all plays for a given UTC date
#'
#' @param date Required date filter in ISO 8601 format (YYYY-MM-DD)
#' @param shooting_plays_only Optional filter to only return shooting plays
#' @param utc_offset Optional UTC offset in hours to adjust the date range
#'
#' @export
#'
get_plays_by_date <- function(date, shooting_plays_only = NULL, utc_offset = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(is_iso_8601(date))
  if (!is.null(shooting_plays_only)) stopifnot(!is.na(as.logical(shooting_plays_only)))
  if (!is.null(utc_offset)) stopifnot(!is.na(as.numeric(utc_offset)))
  # perform api call
  query_cbbd("plays/date", list("date" = date, "shootingPlaysOnly" = shooting_plays_only, "utcOffset" = utc_offset))
}

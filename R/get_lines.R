#' get_lines
#'
#' @description Returns betting lines for up to 3,000 games that match the filters, ordered by start date.
#'
#' @param season Filters results to the specified season.
#' @param team Filters results to the specified team name.
#' @param conference Filters results to the specified conference abbreviation.
#' @param start_date_range Includes games starting at or after this ISO 8601 timestamp.
#' @param end_date_range Includes games starting at or before this ISO 8601 timestamp.
#'
#' @export
#'
get_lines <- function(season = NULL, team = NULL, conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(season)) stopifnot(!is.na(as.integer(season)))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(start_date_range)) stopifnot(is_iso_8601(start_date_range))
  if (!is.null(end_date_range)) stopifnot(is_iso_8601(end_date_range))
  # perform api call
  query_cbbd("lines", list("season" = season, "team" = team, "conference" = conference, "startDateRange" = start_date_range, "endDateRange" = end_date_range))
}

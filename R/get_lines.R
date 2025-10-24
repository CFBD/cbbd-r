#' get_lines
#'
#' @description Returns betting lines for the first 3000 games that match the provided filters, ordered by start date.
#'
#' @param season Optional season filter
#' @param team Optional team name filter
#' @param conference Optional conference abbreviation filter
#' @param start_date_range Optional start timestamp in ISO 8601 format
#' @param end_date_range Optional end timestamp in ISO 8601 format
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

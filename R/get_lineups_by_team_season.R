#' get_lineups_by_team_season
#'
#' @description Returns lineup statistics for a team and season.
#'
#' @param season The season to return.
#' @param team The team name to return.
#' @param start_date_range Includes games starting at or after this ISO 8601 timestamp.
#' @param end_date_range Includes games starting at or before this ISO 8601 timestamp.
#'
#' @export
#'
get_lineups_by_team_season <- function(season, team, start_date_range = NULL, end_date_range = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(season)))
  stopifnot(is.character(team))
  if (!is.null(start_date_range)) stopifnot(is_iso_8601(start_date_range))
  if (!is.null(end_date_range)) stopifnot(is_iso_8601(end_date_range))
  # perform api call
  query_cbbd("lineups/team", list("season" = season, "team" = team, "startDateRange" = start_date_range, "endDateRange" = end_date_range))
}

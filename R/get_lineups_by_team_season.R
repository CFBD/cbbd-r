#' get_lineups_by_team_season
#'
#' @description Queries lineup statistics for a given team and season
#'
#' @param season Required season filter
#' @param team Required team filter
#' @param start_date_range Optional start date range filter
#' @param end_date_range Optional end date range filter
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

#' get_team_season_shooting_stats
#'
#' @description Retrieves team season shooting statistics
#'
#' @param season Required season filter
#' @param season_type Optional season type filter
#' @param team Team filter, required if conference is not provided
#' @param conference Conference abbreviation filter, required if team is not provided
#' @param start_date_range Optional start date range filter
#' @param end_date_range Optional end date range filter
#'
#' @export
#'
get_team_season_shooting_stats <- function(season, season_type = NULL, team = NULL, conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(season)))
  if (!is.null(season_type)) stopifnot(season_type %in% c("postseason", "preseason", "regular") & is.character(season_type))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(start_date_range)) stopifnot(is_iso_8601(start_date_range))
  if (!is.null(end_date_range)) stopifnot(is_iso_8601(end_date_range))
  # perform api call
  query_cbbd("stats/team/shooting/season", list("season" = season, "seasonType" = season_type, "team" = team, "conference" = conference, "startDateRange" = start_date_range, "endDateRange" = end_date_range))
}

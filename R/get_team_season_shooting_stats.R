#' get_team_season_shooting_stats
#'
#' @description Returns team shooting statistics for a season. Provide a team or conference.
#'
#' @param season The season to return.
#' @param season_type Filters results to the specified season type.
#' @param team Filters results to the specified team name. Required when conference is not provided.
#' @param conference Filters results to the specified conference abbreviation. Required when team is not provided.
#' @param start_date_range Includes games starting at or after this ISO 8601 timestamp.
#' @param end_date_range Includes games starting at or before this ISO 8601 timestamp.
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

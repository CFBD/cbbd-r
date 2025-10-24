#' get_player_season_stats
#'
#' @description Returns player statistics by season
#'
#' @param season Required season filter
#' @param season_type Optional season type filter
#' @param team Optional team name filter
#' @param conference Optional conference abbreviation filter
#' @param start_date_range Required season filter
#' @param end_date_range Optional season type filter
#'
#' @export
#'
get_player_season_stats <- function(season, season_type = NULL, team = NULL, conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.numeric(season)))
  if (!is.null(season_type)) stopifnot(season_type %in% c("postseason", "preseason", "regular") & is.character(season_type))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(start_date_range)) stopifnot(is_iso_8601(start_date_range))
  if (!is.null(end_date_range)) stopifnot(is_iso_8601(end_date_range))
  # perform api call
  query_cbbd("stats/player/season", list("season" = season, "seasonType" = season_type, "team" = team, "conference" = conference, "startDateRange" = start_date_range, "endDateRange" = end_date_range))
}

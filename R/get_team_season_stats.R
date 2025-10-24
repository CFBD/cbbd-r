#' get_team_season_stats
#'
#' @description Returns team season statistics by year or team
#'
#' @param season Optional season filter, required if team is not provided
#' @param season_type Optional season type filter
#' @param team Optional team name filter, required if season is not provided
#' @param conference Optional conference abbreviation filter
#' @param start_date_range Optional season filter, required if team is not provided
#' @param end_date_range Optional season type filter
#'
#' @export
#'
get_team_season_stats <- function(season = NULL, season_type = NULL, team = NULL, conference = NULL, start_date_range = NULL, end_date_range = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(season)) stopifnot(!is.na(as.numeric(season)))
  if (!is.null(season_type)) stopifnot(season_type %in% c("postseason", "preseason", "regular") & is.character(season_type))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(start_date_range)) stopifnot(is_iso_8601(start_date_range))
  if (!is.null(end_date_range)) stopifnot(is_iso_8601(end_date_range))
  # perform api call
  query_cbbd("stats/team/season", list("season" = season, "seasonType" = season_type, "team" = team, "conference" = conference, "startDateRange" = start_date_range, "endDateRange" = end_date_range))
}

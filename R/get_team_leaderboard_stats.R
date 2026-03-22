#' get_team_leaderboard_stats
#'
#' @description Returns premium team leaderboard statistics by season, team, or conference (requires a Patreon Tier 2 subscription or higher)
#'
#' @param season Optional season filter
#' @param team Optional team name filter
#' @param conference Optional conference abbreviation filter
#'
#' @export
#'
get_team_leaderboard_stats <- function(season = NULL, team = NULL, conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(season)) stopifnot(!is.na(as.numeric(season)))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("stats/team/leaderboard", list("season" = season, "team" = team, "conference" = conference))
}

#' get_team_leaderboard_stats
#'
#' @description Returns team leaderboard statistics. This endpoint requires Patreon Tier 2 access or higher.
#'
#' @param season Filters results to the specified season.
#' @param team Filters results to the specified team name.
#' @param conference Filters results to the specified conference abbreviation.
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

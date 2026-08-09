#' get_team_roster
#'
#' @description Returns team rosters for a season.
#'
#' @param season The season to return.
#' @param team Filters results to the specified team name.
#'
#' @export
#'
get_team_roster <- function(season, team = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(season)))
  if (!is.null(team)) stopifnot(is.character(team))
  # perform api call
  query_cbbd("teams/roster", list("season" = season, "team" = team))
}

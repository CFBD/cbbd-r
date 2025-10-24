#' get_team_roster
#'
#' @description Retrieves team roster information
#'
#' @param season Season filter
#' @param team Optional team filter
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

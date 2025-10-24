#' get_substitutions_by_team
#'
#' @description Retrieve all player substitutions for a given team and season
#'
#' @param season Required season filter
#' @param team Required team filter
#'
#' @export
#'
get_substitutions_by_team <- function(season, team) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(season)))
  stopifnot(is.character(team))
  # perform api call
  query_cbbd("substitutions/team", list("season" = season, "team" = team))
}

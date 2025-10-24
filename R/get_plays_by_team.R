#' get_plays_by_team
#'
#' @description Retrieve all plays for a given team and season
#'
#' @param season Required season filter
#' @param team Required team filter
#' @param shooting_plays_only Optional filter to only return shooting plays
#'
#' @export
#'
get_plays_by_team <- function(season, team, shooting_plays_only = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(season)))
  stopifnot(is.character(team))
  if (!is.null(shooting_plays_only)) stopifnot(!is.na(as.logical(shooting_plays_only)))
  # perform api call
  query_cbbd("plays/team", list("season" = season, "team" = team, "shootingPlaysOnly" = shooting_plays_only))
}

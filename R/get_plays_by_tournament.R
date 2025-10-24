#' get_plays_by_tournament
#'
#' @description Retrieve all plays for a given tournament and season
#'
#' @param tournament Required tournament filter (e.g. NCAA, NIT, etc)
#' @param season Required season filter
#' @param shooting_plays_only Optional filter to only return shooting plays
#'
#' @export
#'
get_plays_by_tournament <- function(tournament, season, shooting_plays_only = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(is.character(tournament))
  stopifnot(!is.na(as.numeric(season)))
  if (!is.null(shooting_plays_only)) stopifnot(!is.na(as.logical(shooting_plays_only)))
  # perform api call
  query_cbbd("plays/tournament", list("tournament" = tournament, "season" = season, "shootingPlaysOnly" = shooting_plays_only))
}

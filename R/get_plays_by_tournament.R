#' get_plays_by_tournament
#'
#' @description Returns all recorded plays for a tournament and season.
#'
#' @param tournament The tournament to return, such as NCAA or NIT.
#' @param season The season to return.
#' @param shooting_plays_only When true, returns only shooting plays.
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

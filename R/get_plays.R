#' get_plays
#'
#' @description Returns all recorded plays for a game.
#'
#' @param game_id The game ID.
#' @param shooting_plays_only When true, returns only shooting plays.
#'
#' @export
#'
get_plays <- function(game_id, shooting_plays_only = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(game_id)))
  if (!is.null(shooting_plays_only)) stopifnot(!is.na(as.logical(shooting_plays_only)))
  # perform api call
  query_cbbd(paste0("plays/game/", game_id), list("shootingPlaysOnly" = shooting_plays_only))
}

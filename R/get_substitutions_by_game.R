#' get_substitutions_by_game
#'
#' @description Returns all recorded player substitutions for a game.
#'
#' @param game_id The game ID.
#'
#' @export
#'
get_substitutions_by_game <- function(game_id) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(game_id)))
  # perform api call
  query_cbbd(paste0("substitutions/game/", game_id))
}

#' get_substitutions_by_game
#'
#' @description Returns all player substitutions for a given game
#'
#' @param game_id Game id filter
#'
#' @export
#'
get_substitutions_by_game <- function(game_id) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(game_id)))
  # perform api call
  query_cbbd(paste0("substitutions/game/", game_id))
}

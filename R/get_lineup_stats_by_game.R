#' get_lineup_stats_by_game
#'
#' @description Returns lineup statistics for a game.
#'
#' @param game_id The game ID.
#'
#' @export
#'
get_lineup_stats_by_game <- function(game_id) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(game_id)))
  # perform api call
  query_cbbd(paste0("lineups/game/", game_id))
}

#' get_lineup_stats_by_game
#'
#' @description Queries lineup statistics for a specific game
#'
#' @param game_id Required game id filter
#'
#' @export
#'
get_lineup_stats_by_game <- function(game_id) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(game_id)))
  # perform api call
  query_cbbd(paste0("lineups/game/", game_id))
}

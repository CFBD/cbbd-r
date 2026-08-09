#' get_substitutions_by_player_id
#'
#' @description Returns all recorded player substitutions for a player and season.
#'
#' @param player_id The player ID.
#' @param season The season to return.
#'
#' @export
#'
get_substitutions_by_player_id <- function(player_id, season) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(player_id)))
  stopifnot(!is.na(as.integer(season)))
  # perform api call
  query_cbbd(paste0("substitutions/player/", player_id), list("season" = season))
}

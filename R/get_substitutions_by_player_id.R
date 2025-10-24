#' get_substitutions_by_player_id
#'
#' @description Retrieve all player substitutions for a given player and season
#'
#' @param player_id Required player id filter
#' @param season Required season filter
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

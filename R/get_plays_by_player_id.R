#' get_plays_by_player_id
#'
#' @description Returns all recorded plays for a player and season.
#'
#' @param player_id The player ID.
#' @param season The season to return.
#' @param shooting_plays_only When true, returns only shooting plays.
#'
#' @export
#'
get_plays_by_player_id <- function(player_id, season, shooting_plays_only = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(player_id)))
  stopifnot(!is.na(as.integer(season)))
  if (!is.null(shooting_plays_only)) stopifnot(!is.na(as.logical(shooting_plays_only)))
  # perform api call
  query_cbbd(paste0("plays/player/", player_id), list("season" = season, "shootingPlaysOnly" = shooting_plays_only))
}

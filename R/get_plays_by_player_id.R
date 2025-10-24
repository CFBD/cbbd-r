#' get_plays_by_player_id
#'
#' @description Retrieve all plays for a given player and season
#'
#' @param player_id Required player id filter
#' @param season Required season filter
#' @param shooting_plays_only Optional filter to only return shooting plays
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

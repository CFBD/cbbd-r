#' get_plays
#'
#' @description Returns all plays for a given game
#'
#' @param game_id Game id filter
#' @param shooting_plays_only Optional filter to only return shooting plays
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

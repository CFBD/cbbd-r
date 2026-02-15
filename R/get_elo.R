#' get_elo
#'
#' @description Retrieves historical Elo ratings
#'
#' @param season Optional season filter
#' @param team Optional team filter
#' @param conference Optional conference filter
#'
#' @export
#'
get_elo <- function(season = NULL, team = NULL, conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(season)) stopifnot(!is.na(as.integer(season)))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("ratings/elo", list("season" = season, "team" = team, "conference" = conference))
}

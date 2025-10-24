#' get_recruits
#'
#' @description Retrieves historical composite player recruiting ranking and ratings
#'
#' @param year Optional year filter
#' @param team Optional college team filter
#' @param conference Optional college conference filter
#' @param position Optional position filter
#'
#' @export
#'
get_recruits <- function(year = NULL, team = NULL, conference = NULL, position = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(year)) stopifnot(!is.na(as.integer(year)))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(position)) stopifnot(is.character(position))
  # perform api call
  query_cbbd("recruiting/players", list("year" = year, "team" = team, "conference" = conference, "position" = position))
}

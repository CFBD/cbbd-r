#' get_recruits
#'
#' @description Returns historical composite player recruiting rankings and ratings.
#'
#' @param year Filters results to the specified recruiting year.
#' @param team Filters results to the specified college team.
#' @param conference Filters results to the specified conference abbreviation.
#' @param position Filters results to the specified player position.
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

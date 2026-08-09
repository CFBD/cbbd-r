#' get_team_recruiting_rankings
#'
#' @description Returns historical composite team recruiting rankings.
#'
#' @param year Filters results to the specified recruiting year.
#' @param team Filters results to the specified team name.
#' @param conference Filters results to the specified conference abbreviation.
#'
#' @export
#'
get_team_recruiting_rankings <- function(year = NULL, team = NULL, conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(year)) stopifnot(!is.na(as.integer(year)))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("recruiting/teams", list("year" = year, "team" = team, "conference" = conference))
}

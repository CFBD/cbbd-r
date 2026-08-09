#' get_adjusted_efficiency
#'
#' @description Returns adjusted offensive and defensive efficiency ratings.
#'
#' @param season Filters results to the specified season.
#' @param team Filters results to the specified team name.
#' @param conference Filters results to the specified conference abbreviation.
#'
#' @export
#'
get_adjusted_efficiency <- function(season = NULL, team = NULL, conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(season)) stopifnot(!is.na(as.integer(season)))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("ratings/adjusted", list("season" = season, "team" = team, "conference" = conference))
}

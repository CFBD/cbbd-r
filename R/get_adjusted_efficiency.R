#' get_adjusted_efficiency
#'
#' @description Retrieves adjusted efficiency ratings for the provided season, team, or conference.
#'
#' @param season Optional season filter
#' @param team Optional team filter
#' @param conference Optional conference abbreviation filter
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

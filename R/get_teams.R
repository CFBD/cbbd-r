#' get_teams
#'
#' @description Returns team and conference information.
#'
#' @param conference Filters results to the specified conference abbreviation.
#' @param season Returns conference membership for the specified season.
#'
#' @export
#'
get_teams <- function(conference = NULL, season = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(season)) stopifnot(!is.na(as.integer(season)))
  # perform api call
  query_cbbd("teams", list("conference" = conference, "season" = season))
}

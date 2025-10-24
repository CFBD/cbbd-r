#' get_teams
#'
#' @description Retrieves historical team information
#'
#' @param conference Optional conference filter
#' @param season Optional season filter
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

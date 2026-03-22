#' get_scoreboard
#'
#' @description Retrieves live scoreboard data (requires a Patreon Tier 1 subscription or higher)
#'
#' @param conference Optional conference filter
#'
#' @export
#'
get_scoreboard <- function(conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("scoreboard", list("conference" = conference))
}

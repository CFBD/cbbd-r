#' get_scoreboard
#'
#' @description Returns live scoreboard data. This endpoint requires Patreon Tier 1 access or higher.
#'
#' @param conference Filters results to the specified conference abbreviation.
#'
#' @export
#'
get_scoreboard <- function(conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("scoreboard", list("conference" = conference))
}

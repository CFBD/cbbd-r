#' get_conference_history
#'
#' @description Returns historical conference membership records.
#'
#' @param conference Filters results to the specified conference abbreviation.
#'
#' @export
#'
get_conference_history <- function(conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("conferences/history", list("conference" = conference))
}

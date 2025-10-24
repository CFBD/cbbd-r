#' get_conference_history
#'
#' @description Retrieves historical conference membership information
#'
#' @param conference Optional conference abbreviation filter
#'
#' @export
#'
get_conference_history <- function(conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("conferences/history", list("conference" = conference))
}

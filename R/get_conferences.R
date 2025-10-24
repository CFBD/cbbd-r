#' get_conferences
#'
#' @description Retrieves list of available conferences
#'
#' @export
#'
get_conferences <- function() {
  # perform api call
  query_cbbd("conferences")
}

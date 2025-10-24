#' get_venues
#'
#' @description Retrieves list of available venues
#'
#' @export
#'
get_venues <- function() {
  # perform api call
  query_cbbd("venues")
}

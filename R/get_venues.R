#' get_venues
#'
#' @description Returns available venues and location information.
#'
#' @export
#'
get_venues <- function() {
  # perform api call
  query_cbbd("venues")
}

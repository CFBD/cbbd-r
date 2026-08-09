#' get_conferences
#'
#' @description Returns available conferences and their identifiers.
#'
#' @export
#'
get_conferences <- function() {
  # perform api call
  query_cbbd("conferences")
}

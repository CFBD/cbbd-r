#' get_play_types
#'
#' @description Returns available play types and their identifiers.
#'
#' @export
#'
get_play_types <- function() {
  # perform api call
  query_cbbd("plays/types")
}

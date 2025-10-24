#' get_play_types
#'
#' @description Retrieve list of play types
#'
#' @export
#'
get_play_types <- function() {
  # perform api call
  query_cbbd("plays/types")
}

#' get_draft_positions
#'
#' @description Retrieves list of position names for NBA draft prospects
#'
#' @export
#'
get_draft_positions <- function() {
  # perform api call
  query_cbbd("draft/positions")
}

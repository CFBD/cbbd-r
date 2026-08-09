#' get_draft_positions
#'
#' @description Returns player positions represented in the draft data.
#'
#' @export
#'
get_draft_positions <- function() {
  # perform api call
  query_cbbd("draft/positions")
}

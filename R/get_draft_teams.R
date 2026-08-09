#' get_draft_teams
#'
#' @description Returns NBA teams represented in the draft data.
#'
#' @export
#'
get_draft_teams <- function() {
  # perform api call
  query_cbbd("draft/teams")
}

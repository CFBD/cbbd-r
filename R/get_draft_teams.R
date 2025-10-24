#' get_draft_teams
#'
#' @description Retrieves list of NBA teams
#'
#' @export
#'
get_draft_teams <- function() {
  # perform api call
  query_cbbd("draft/teams")
}

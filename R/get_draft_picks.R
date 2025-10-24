#' get_draft_picks
#'
#' @description Retrieves historical NBA draft picks
#'
#' @param year Optional draft year filter
#' @param draft_team Optional NBA team filter
#' @param source_team Optional source team (e.g. NCAA) filter
#' @param position Optional player position abbreviation filter
#'
#' @export
#'
get_draft_picks <- function(year = NULL, draft_team = NULL, source_team = NULL, position = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(year)) stopifnot(!is.na(as.integer(year)))
  if (!is.null(draft_team)) stopifnot(is.character(draft_team))
  if (!is.null(source_team)) stopifnot(is.character(source_team))
  if (!is.null(position)) stopifnot(is.character(position))
  # perform api call
  query_cbbd("draft/picks", list("year" = year, "draftTeam" = draft_team, "sourceTeam" = source_team, "position" = position))
}

#' get_draft_picks
#'
#' @description Returns historical NBA draft picks.
#'
#' @param year Filters results to the specified draft year.
#' @param draft_team Filters results to the specified NBA team.
#' @param source_team Filters results to the specified college team.
#' @param position Filters results to the specified player position abbreviation.
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

#' get_portal_transfers
#'
#' @description Retrieves historical transfer portal activity
#'
#' @param year Source team filter
#' @param source_team Destination team filter
#' @param destination_team Source conference filter
#' @param source_conference Destination conference filter
#' @param destination_conference Position filter
#' @param position Source team filter
#'
#' @export
#'
get_portal_transfers <- function(year = NULL, source_team = NULL, destination_team = NULL, source_conference = NULL, destination_conference = NULL, position = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(year)) stopifnot(!is.na(as.numeric(year)))
  if (!is.null(source_team)) stopifnot(is.character(source_team))
  if (!is.null(destination_team)) stopifnot(is.character(destination_team))
  if (!is.null(source_conference)) stopifnot(is.character(source_conference))
  if (!is.null(destination_conference)) stopifnot(is.character(destination_conference))
  if (!is.null(position)) stopifnot(is.character(position))
  # perform api call
  query_cbbd("recruiting/portal", list("year" = year, "sourceTeam" = source_team, "destinationTeam" = destination_team, "sourceConference" = source_conference, "destinationConference" = destination_conference, "position" = position))
}

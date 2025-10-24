#' get_rankings
#'
#' @description Retrieves historical poll data
#'
#' @param season Optional season filter
#' @param season_type Optional season type filter
#' @param week Optional week filter
#' @param poll_type Optional poll type filter ("ap" or "coaches")
#' @param team Optional team filter
#' @param conference Optional conference filter
#'
#' @export
#'
get_rankings <- function(season = NULL, season_type = NULL, week = NULL, poll_type = NULL, team = NULL, conference = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(season)) stopifnot(!is.na(as.integer(season)))
  if (!is.null(season_type)) stopifnot(season_type %in% c("postseason", "preseason", "regular") & is.character(season_type))
  if (!is.null(week)) stopifnot(!is.na(as.integer(week)))
  if (!is.null(poll_type)) stopifnot(poll_type %in% c("ap", "coaches") & is.character(poll_type))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  # perform api call
  query_cbbd("rankings", list("season" = season, "seasonType" = season_type, "week" = week, "pollType" = poll_type, "team" = team, "conference" = conference))
}

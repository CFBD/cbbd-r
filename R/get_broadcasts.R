#' get_broadcasts
#'
#' @description Returns broadcast information on the first 3000 games that match the provided filters, ordered by start date.
#'
#' @param start_date_range Optional start timestamp in ISO 8601 format
#' @param end_date_range Optional end timestamp in ISO 8601 format
#' @param team Optional team name filter
#' @param conference Optional conference abbreviation filter
#' @param season Optional season filter
#' @param season_type Optional season type filter
#' @param tournament Optional tournament filter (e.g. NCAA, NIT, etc)
#'
#' @export
#'
get_broadcasts <- function(start_date_range = NULL, end_date_range = NULL, team = NULL, conference = NULL, season = NULL, season_type = NULL, tournament = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(start_date_range)) stopifnot(is_iso_8601(start_date_range))
  if (!is.null(end_date_range)) stopifnot(is_iso_8601(end_date_range))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(season)) stopifnot(!is.na(as.numeric(season)))
  if (!is.null(season_type)) stopifnot(season_type %in% c("postseason", "preseason", "regular") & is.character(season_type))
  if (!is.null(tournament)) stopifnot(is.character(tournament))
  # perform api call
  query_cbbd("games/media", list("startDateRange" = start_date_range, "endDateRange" = end_date_range, "team" = team, "conference" = conference, "season" = season, "seasonType" = season_type, "tournament" = tournament))
}

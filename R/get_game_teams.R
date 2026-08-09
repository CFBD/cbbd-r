#' get_game_teams
#'
#' @description Returns team box scores and advanced metrics for up to 3,000 games that match the filters, ordered by start date.
#'
#' @param start_date_range Includes games starting at or after this ISO 8601 timestamp.
#' @param end_date_range Includes games starting at or before this ISO 8601 timestamp.
#' @param team Filters results to the specified team name.
#' @param conference Filters results to the specified conference abbreviation.
#' @param season Filters results to the specified season.
#' @param season_type Filters results to the specified season type.
#' @param tournament Filters results to the specified tournament, such as NCAA or NIT.
#'
#' @export
#'
get_game_teams <- function(start_date_range = NULL, end_date_range = NULL, team = NULL, conference = NULL, season = NULL, season_type = NULL, tournament = NULL) {
  # ensure arguments are passed in correctly
  if (!is.null(start_date_range)) stopifnot(is_iso_8601(start_date_range))
  if (!is.null(end_date_range)) stopifnot(is_iso_8601(end_date_range))
  if (!is.null(team)) stopifnot(is.character(team))
  if (!is.null(conference)) stopifnot(is.character(conference))
  if (!is.null(season)) stopifnot(!is.na(as.numeric(season)))
  if (!is.null(season_type)) stopifnot(season_type %in% c("postseason", "preseason", "regular") & is.character(season_type))
  if (!is.null(tournament)) stopifnot(is.character(tournament))
  # perform api call
  query_cbbd("games/teams", list("startDateRange" = start_date_range, "endDateRange" = end_date_range, "team" = team, "conference" = conference, "season" = season, "seasonType" = season_type, "tournament" = tournament))
}

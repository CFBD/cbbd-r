#' get_overview
#'
#' @description Returns a stored full-season team overview
#'
#' @param team_id Team ID filter
#' @param season Season filter
#'
#' @export
#'
get_overview <- function(team_id, season) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(team_id)))
  stopifnot(!is.na(as.integer(season)))
  # perform api call
  query_cbbd(paste0("teams/", team_id) / overview)
}

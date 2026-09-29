#' get_directory
#'
#' @description Returns full team directory and metadata for the specified season.
#'
#' @param season
#'
#' @export
#'
get_directory <- function(season) {
  # ensure arguments are passed in correctly
  stopifnot(!is.na(as.integer(season)))
  # perform api call
  query_cbbd("teams/directory", list("season" = season))
}

#' get_plays_by_date
#'
#' @description Returns all recorded plays for a UTC date.
#'
#' @param date The date to return in ISO 8601 format (YYYY-MM-DD).
#' @param shooting_plays_only When true, returns only shooting plays.
#' @param utc_offset Shifts the date range by this number of hours from UTC.
#'
#' @export
#'
get_plays_by_date <- function(date, shooting_plays_only = NULL, utc_offset = NULL) {
  # ensure arguments are passed in correctly
  stopifnot(is_iso_8601(date))
  if (!is.null(shooting_plays_only)) stopifnot(!is.na(as.logical(shooting_plays_only)))
  if (!is.null(utc_offset)) stopifnot(!is.na(as.numeric(utc_offset)))
  # perform api call
  query_cbbd("plays/date", list("date" = date, "shootingPlaysOnly" = shooting_plays_only, "utcOffset" = utc_offset))
}

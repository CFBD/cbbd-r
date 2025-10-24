#' get_providers
#'
#' @description Returns available betting data providers
#'
#' @export
#'
get_providers <- function() {
  # perform api call
  query_cbbd("lines/providers")
}

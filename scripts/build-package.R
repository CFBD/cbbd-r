# grab API docs
api_docs <- jsonlite::read_json(
  "https://api.collegebasketballdata.com/api-docs.json"
)

# helper function for generating a test string for each schema
gen_check_string <- function(p) {
  if (length(p) == 0) {
    return("")
  }
  snake_name <- snakecase::to_snake_case(p$name)
  start_string <- paste0(
    ifelse(p$required, "", paste0("if(!is.null(", snake_name, ")) ")),
    "stopifnot("
  )
  if (length(p$schema)) {
    if (length(p$schema$`$ref`)) {
      schema_name <- tail(strsplit(p$schema$`$ref`, "/")[[1]], 1)
      valid_values <- unlist(api_docs$components$schemas[[schema_name]]$enum)
      type <- api_docs$components$schemas[[schema_name]]$type
      type <- switch(
        type,
        "string" = "is.character",
        "integer" = "is.integer",
        "number" = "is.double",
        "boolean" = "is.logical"
      )
      return(paste0(
        start_string,
        snake_name,
        " %in% c('",
        paste0(valid_values, collapse = "','"),
        "') & ",
        type,
        "(",
        snake_name,
        "))"
      ))
    } else if (length(p$schema$enum)) {
      valid_values <- unlist(p$schema$enum)
      type <- p$schema$type
      type <- switch(
        type,
        "string" = "is.character",
        "integer" = "is.integer",
        "number" = "is.double",
        "boolean" = "is.logical"
      )
      return(paste0(
        start_string,
        snake_name,
        " %in% c('",
        paste0(valid_values, collapse = "','"),
        "') & ",
        type,
        "(",
        snake_name,
        "))"
      ))
    } else if (p$schema$type == "string") {
      if (length(p$schema$format) && p$schema$format == "date-time") {
        return(paste0(start_string, "is_iso_8601(", snake_name, "))"))
      }
      return(paste0(start_string, "is.character(", snake_name, "))"))
    } else if (p$schema$type == "integer") {
      return(paste0(start_string, "!is.na(as.integer(", snake_name, ")))"))
    } else if (p$schema$type == "number") {
      return(paste0(start_string, "!is.na(as.numeric(", snake_name, ")))"))
    } else if (p$schema$type == "boolean") {
      return(paste0(start_string, "!is.na(as.logical(", snake_name, ")))"))
    }
  }
}

# generate functions for each endpoint
for (endpoint in names(api_docs$paths)) {
  path <- api_docs$paths[[endpoint]]
  function_name <- snakecase::to_snake_case(path$get$operationId)
  if (endpoint == "/lines/providers") {
    description <- "Returns available betting data providers"
  } else {
    description <- path$get$description
  }
  parameters <- path$get$parameters

  parameter_descs <- purrr::map(parameters, \(x) x$description) |> unlist()
  parameter_names <- purrr::map(parameters, \(x) x$name) |> unlist()
  parameter_req <- purrr::map(parameters, \(x) x$required) |> unlist()

  if (length(parameter_names)) {
    parameter_names_snake <- snakecase::to_snake_case(parameter_names)
    parameters_formatted <- paste(
      "#' @param",
      parameter_names_snake,
      parameter_descs
    )
  } else {
    parameters_formatted <- ""
    parameter_names_snake <- ""
  }

  function_assignment <- paste(
    function_name,
    "<- function(",
    paste0(
      paste0(parameter_names_snake, ifelse(parameter_req, "", " = NULL")),
      collapse = ", "
    ),
    ") {"
  )

  # create checks to ensure passed in parameters are valid
  check_args <- purrr::map(parameters, gen_check_string) |> unlist()

  # format a request to the cbbd API
  if (grepl("\\{.*\\}", endpoint)) {
    url_param <- parameter_names_snake[stringr::str_detect(
      endpoint,
      paste0("\\{", parameter_names, "\\}")
    )]
    parameter_names <- parameter_names[which(
      parameter_names_snake != url_param
    )]
    parameter_names_snake <- parameter_names_snake[which(
      parameter_names_snake != url_param
    )]
    endpoint_format <- paste0(
      "paste0('",
      sub(
        "\\{.*\\}",
        paste0(
          "', ",
          url_param,
          ")"
        ),
        sub(
          "/",
          "",
          endpoint
        )
      )
    )
  } else {
    endpoint_format <- paste0("'", sub("/", "", endpoint), "'")
  }
  api_request <- paste0(
    "query_cbbd(",
    endpoint_format,
    ifelse(
      length(parameter_names),
      paste0(
        ", list(",
        paste0(
          paste0("'", parameter_names, "' = ", parameter_names_snake),
          collapse = ","
        ),
        ")"
      ),
      ""
    ),
    ")"
  )

  if (length(parameters)) {
    writeLines(
      c(
        paste("#'", function_name),
        "#'",
        paste("#' @description", description),
        "#'",
        parameters_formatted,
        "#'",
        "#' @export",
        "#' ",
        function_assignment,
        "# ensure arguments are passed in correctly",
        check_args,
        "# perform api call",
        api_request,
        "}"
      ),
      file.path("R", paste0(function_name, ".R"))
    )
  } else {
    writeLines(
      c(
        paste("#'", function_name),
        "#'",
        paste("#' @description", description),
        "#'",
        "#' @export",
        "#'",
        function_assignment,
        "# perform api call",
        api_request,
        "}"
      ),
      file.path("R", paste0(function_name, ".R"))
    )
  }
}

styler::style_dir("R")

devtools::document()

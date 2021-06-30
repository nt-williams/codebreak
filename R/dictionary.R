#' Label data based on a data dictionary
#'
#' @param .data The data to label.
#' @param path The path to JSON data dictionary.
#'
#' @return The data with the columns found in the data dictionary labeled.
#' @export
#'
#' @examples
#' ex <- data.frame(
#'   x = c(1, 2, 5, 3, 4),
#'   y = c(0, 1, 1, 0, 1)
#' )
#' dictionary(ex, system.file("dictionary.json", package = "dictionary"))
dictionary <- function(.data, path = "dictionary.json") {
  if (!file.exists(path)) stop("Dictionary not found. Check your file path!")

  dict <- jsonlite::fromJSON(path)
  out <- .data
  modify <- names(dict)
  modify <- modify[modify %in% names(.data)]
  lapply(modify, function(x) {
    out[[x]] <<- sapply(
      as.character(out[[x]]), function(key) {
        if (is.na(key)) return(NA_character_)
        dict[[x]][[key]]
      }, USE.NAMES = FALSE
    )
  })
  out
}

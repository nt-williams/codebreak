#' Label data based on a data dictionary
#'
#' @param .data
#' @param path
#'
#' @return
#' @export
#'
#' @examples
dictionary <- function(.data, path = "dictionary.json") {
  dict <- jsonlite::fromJSON(path)
  out <- .data
  modify <- names(dict)
  modify <- modify[modify %in% names(.data)]
  lapply(modify, function(x) {
    out[[x]] <<- sapply(out[[x]], function(key) {
      if (is.na(key)) return(NA_character_)
      dict[[x]][[key]]
    }, USE.NAMES = FALSE)
  })
  out
}

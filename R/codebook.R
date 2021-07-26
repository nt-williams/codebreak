#' Label data based on a code book.
#'
#' @param .data The data to label.
#' @param path The path to YAML code book.
#'
#' @return The data with the columns found in the code book labeled.
#' @export
#'
#' @examples
#' ex <- data.frame(
#'   x = c(1, 2, 5, 3, 4),
#'   y = c(0, 1, 1, 0, 1),
#'   z = rnorm(5),
#'   w = c(1, 1, 0, 1, 1)
#' )
#' codebook(ex, system.file("codebook.yml", package = "codebook"))
codebook <- function(.data, path = "dictionary.yml") {
  check_path(path)
  dict <- get_dictionary(path)
  result <- .data
  modify <- to_modify(.data, dict)
  lapply(modify, function(x) {
    result[[x]] <<- sapply(
      as.character(result[[x]]), function(key) {
        if (is.na(key)) return(NA_character_)
        dict[[x]][[key]]
      }, USE.NAMES = FALSE
    )
  })
  result
}

get_dictionary <- function(path) {
  cb <- yaml::read_yaml(path)
  purrr::discard(lapply(cb, function(x) x$cb), is.null)
}

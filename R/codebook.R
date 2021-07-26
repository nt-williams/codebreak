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
#'   z = rnorm(5)
#' )
#' codebook(ex, system.file("codebook.yml", package = "codebook"))
codebook <- function(.data, path = "dictionary.yml") {
  if (!file.exists(path)) stop("Codebook not found. Check your file path!")

  dict <- get_dictionary(path)
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

get_dictionary <- function(path) {
  cb <- yaml::read_yaml(path)
  purrr::discard(lapply(cb, function(x) x$cb), is.null)
}

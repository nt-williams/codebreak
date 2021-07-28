#' Label data based on a code book.
#'
#' @param data The data to label.
#' @param path The path to YAML code book.
#' @param label Should column names also be renamed according to code book labels?
#' @param .include An optional character vector of column names to
#'  apply the code book to.
#' @param .exclude An optional character vector of column names to not apply
#'  the code book to. Ignored if \code{.include} is specified.
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
codebook <- function(data, path = "dictionary.yml", label = FALSE,
                     as_labelled = FALSE,
                     .include = NULL, .exclude = NULL) {
  check_path(path)
  codebook <- yaml::read_yaml(path)
  dict <- get_dictionary_codebook(codebook)
  result <- data
  modify <- to_modify(data, dict, .include, .exclude)

  assert_no_unknown_levels(data, dict, modify)

  if (as_labelled) {
    return(set_labelled_labels(data, codebook, modify, label))
  }

  lapply(modify, function(x) {
    result[[x]] <<- sapply(
      as.character(result[[x]]), function(key) {
        if (is.na(key)) return(NA_character_)
        dict[[x]][[key]]
      }, USE.NAMES = FALSE
    )
  })

  if (isFALSE(label)) return(result)
  label(result, path, .include, .exclude)
}

get_dictionary_codebook <- function(cb) {
  purrr::discard(lapply(cb, function(x) x$cb), is.null)
}

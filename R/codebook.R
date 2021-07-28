#' Label data based on a code book.
#'
#' @param data The data to label.
#' @param path The path to YAML code book.
#' @param label Should column names also be renamed according to code book labels?
#' @param as_labelled Should the code book be applied using the labelled package?
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
                     as_labelled = FALSE, .include = NULL, .exclude = NULL) {
  check_path(path)
  codebook <- yaml::read_yaml(path)

  if (as_labelled) {
    return(set_labelled_labels(data, codebook, label, .include, .exclude))
  }

  set_codebook_labels(data, codebook, label, .include, .exclude)
}

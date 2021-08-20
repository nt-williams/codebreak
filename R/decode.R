#' Label data based on a codebook.
#'
#' @param data The data to label.
#' @param path The path to YAML codebook.
#' @param label Should column names also be renamed according to codebook labels?
#' @param as_labelled Should the codebook be applied using the labelled package?
#' @param .include An optional character vector of column names to
#'  apply the codebook to.
#' @param .exclude An optional character vector of column names to not apply
#'  the codebook to. Ignored if \code{.include} is specified.
#'
#' @return An updated copy of \code{data}.
#'
#' @export
#'
#' @examples
#' ex <- data.frame(
#'   x = c(1, 2, 5, 3, 4),
#'   y = c(0, 1, 1, 0, 1),
#'   z = rnorm(5),
#'   w = c(1, 1, 0, 1, 1)
#' )
#'
#' decode(ex, system.file("codebook.yml", package = "codebreak"))
decode <- function(data, path = "codebook.yml",
                   label = FALSE, as_labelled = FALSE,
                   .include = NULL, .exclude = NULL) {
  assert_valid_path(path)
  codebook <- yaml::read_yaml(path)

  if (as_labelled) {
    return(set_labelled_labels(data, codebook, label, .include, .exclude))
  }

  set_codebook_labels(data, codebook, label, .include, .exclude)
}

#' Rename columns using code book labels
#'
#' @param data The data to label.
#' @param path The path to YAML codebook.
#' @param as_labelled Should the codebook labels be applied using the labelled package?
#' @param .include An optional character vector of column names to
#'  apply the codebook to.
#' @param .exclude An optional character vector of column names to not apply
#'  the codebook to. Ignored if \code{.include} is specified.
#'
#' @return The data with the columns found in the code book renamed.
#' @export
#'
#' @importFrom stats setNames
#'
#' @examples
#' ex <- data.frame(
#'   x = c(1, 2, 5, 3, 4),
#'   y = c(0, 1, 1, 0, 1),
#'   z = rnorm(5),
#'   w = c(1, 1, 0, 1, 1)
#' )
#'
#' label(ex, system.file("codebook.yml", package = "codebreak"))
label <- function(data, path = "codebook.yml",
                  as_labelled = FALSE, .include = NULL, .exclude = NULL) {
  assert_valid_path(path)
  codebook <- yaml::read_yaml(path)

  if (as_labelled) {
    return(set_labelled_var_labels(data, codebook, .include, .exclude))
  }

  set_codebook_var_labels(data, codebook, .include, .exclude)
}

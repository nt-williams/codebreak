#' Rename columns using code book labels
#'
#' @param .data The data to label.
#' @param path The path to YAML code book.
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
#' label(ex, system.file("codebook.yml", package = "codebook"))
label <- function(.data, path = "dictionary.yml") {
  check_path(path)
  labels <- get_labels(path)
  old_names <- names(.data)
  new_names <- old_names
  modify <- to_modify(.data, labels)
  for (i in modify) {
    new_names[which(old_names == i)] <- labels[[i]]
  }
  setNames(.data, new_names)
}

get_labels <- function(path) {
  cb <- yaml::read_yaml(path)
  purrr::discard(lapply(cb, function(x) x$label), is.null)
}

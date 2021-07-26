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

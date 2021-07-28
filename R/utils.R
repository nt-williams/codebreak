to_modify <- function(.data, dict, .include, .exclude) {
  modify <- intersect(names(dict), names(.data))
  if (is.null(.include) && is.null(.exclude)) {
    return(modify)
  }

  if (is.null(.exclude) || !is.null(.exclude) && !is.null(.include)) {
    modify <- intersect(modify, .include)
    return(modify)
  }

  setdiff(modify, .exclude)
}

get_dictionary_codebook <- function(cb) {
  purrr::discard(lapply(cb, function(x) x$cb), is.null)
}

get_labels_path <- function(path) {
  cb <- yaml::read_yaml(path)
  get_labels_codebook(cb)
}

get_labels_codebook <- function(dict) {
  purrr::discard(lapply(cb, function(x) x$label), is.null)
}

conversion <- function(mode, x) {
  switch(
    mode,
    numeric = as.numeric(x),
    character = as.character(x)
  )
}

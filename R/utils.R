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

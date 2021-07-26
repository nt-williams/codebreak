to_modify <- function(.data, dict) {
  modify <- names(dict)
  modify[modify %in% names(.data)]
}

set_labelled_labels <- function(data, cb, modify, var_labels = FALSE) {
  result <- labelled_val_labels(data, cb, modify)
  if (isFALSE(var_labels)) {
    return(result)
  }
  labelled_var_labels(result, cb, modify)
}

labelled_var_labels <- function(data, cb, modify) {
  labels <- get_labels_codebook(cb)[modify]
  labelled::set_variable_labels(data, .labels = labels, .strict = FALSE)
}

labelled_val_labels <- function(data, cb, modify) {
  dict <- get_dictionary_codebook(cb)
  labels <- lapply(modify, function(x) {
    cb <- unlist(dict[[x]])
    labels <- conversion(mode(data[[x]]), names(cb))
    setNames(labels, cb)
  })
  labels <- setNames(labels, modify)
  labelled::set_value_labels(data, .labels = labels, .strict = FALSE)
}


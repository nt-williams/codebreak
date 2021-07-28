set_codebook_labels <- function(data, cb, label, .include, .exclude) {
  result <- codebook_val_labels(data, cb, .include, .exclude)
  if (isFALSE(label)) {
    return(result)
  }
  codebook_var_labels(result, cb, .include, .exclude)
}

codebook_val_labels <- function(data, cb, .include, .exclude) {
  dict <- get_dictionary_codebook(cb)
  modify <- to_modify(data, dict, .include, .exclude)
  assert_no_unknown_levels(data, dict, modify)
  for (x in modify) {
    data[[x]] <- sapply(
      as.character(data[[x]]), function(key) {
        if (is.na(key)) return(NA_character_)
        dict[[x]][[key]]
      }, USE.NAMES = FALSE
    )
  }
  data
}

codebook_var_labels <- function(data, cb, .include, .exclude) {
  labels <- get_labels_codebook(cb)
  modify <- to_modify(data, labels, .include, .exclude)
  old_names <- names(data)
  new_names <- old_names
  for (var in modify) {
    new_names[which(old_names == var)] <- labels[[var]]
  }
  setNames(data, new_names)
}

set_labelled_labels <- function(data, cb, var_labels, .include, .exclude) {
  result <- labelled_val_labels(data, cb, .include, .exclude)
  if (isFALSE(var_labels)) {
    return(result)
  }
  labelled_var_labels(result, cb, .include, .exclude)
}

labelled_var_labels <- function(data, cb, .include, .exclude) {
  labels <- get_labels_codebook(cb)
  modify <- to_modify(data, labels, .include, .exclude)
  labelled::set_variable_labels(data, .labels = labels[modify], .strict = FALSE)
}

labelled_val_labels <- function(data, cb, .include, .exclude) {
  dict <- get_dictionary_codebook(cb)
  modify <- to_modify(data, dict, .include, .exclude)
  assert_no_unknown_levels(data, dict, modify)
  labels <- lapply(modify, function(x) {
    cb <- unlist(dict[[x]])
    labels <- conversion(mode(data[[x]]), names(cb))
    setNames(labels, cb)
  })
  labels <- setNames(labels, modify)
  labelled::set_value_labels(data, .labels = labels, .strict = FALSE)
}

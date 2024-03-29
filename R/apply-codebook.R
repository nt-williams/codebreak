set_codebook_labels <- function(data, cb, label, .include, .exclude) {
  result <- set_codebook_val_labels(data, cb, .include, .exclude)

  if (isFALSE(label)) {
    return(result)
  }

  set_codebook_var_labels(result, cb, .include, .exclude)
}

set_codebook_val_labels <- function(data, cb, .include, .exclude) {
  dict <- cb$dictionary
  modify <- to_modify(data, dict, .include, .exclude)

  assert_no_unknown_levels(data, dict, modify)

  for (var in modify) {
    data[[var]] <- plyr::mapvalues(
      as.character(data[[var]]),
      from = dict[[var]][["key"]],
      to = dict[[var]][["values"]],
      warn_missing = FALSE
    )
  }

  data
}

set_codebook_var_labels <- function(data, cb, .include, .exclude) {
  labels <- cb$labels
  modify <- to_modify(data, labels, .include, .exclude)
  old_names <- names(data)
  new_names <- old_names

  for (var in modify) {
    new_names[which(old_names == var)] <- labels[[var]]
  }

  setNames(data, new_names)
}

set_labelled_labels <- function(data, cb, var_labels, .include, .exclude) {
  result <- set_labelled_val_labels(data, cb, .include, .exclude)

  if (isFALSE(var_labels)) {
    return(result)
  }

  set_labelled_var_labels(result, cb, .include, .exclude, make_labelled = FALSE)
}

set_labelled_var_labels <- function(data, cb, .include, .exclude, make_labelled) {
  labels <- cb$labels
  modify <- to_modify(data, labels, .include, .exclude)

  if (isFALSE(make_labelled)) {
    return(labelled::set_variable_labels(data, .labels = labels[modify], .strict = FALSE))
  }

  for (m in modify) data[[m]] <- labelled::labelled(data[[m]])
  labelled::set_variable_labels(data, .labels = labels[modify], .strict = FALSE)
}

set_labelled_val_labels <- function(data, cb, .include, .exclude) {
  dict <- cb$dictionary
  modify <- to_modify(data, dict, .include, .exclude)

  assert_no_unknown_levels(data, dict, modify)

  labels <- lapply(modify, function(x) {
    cb <- dict[[x]][["values"]]
    labels <- conversion(mode(data[[x]]), dict[[x]][["key"]])
    setNames(labels, cb)
  })

  labels <- setNames(labels, modify)

  fix_labelled_na(
    labelled::set_value_labels(data, .labels = labels, .strict = FALSE),
    modify
  )
}

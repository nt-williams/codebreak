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
  dict_list <- purrr::discard(lapply(cb, function(x) x$cb), is.null)

  result <- lapply(
    names(dict_list),
    function(x) get_key_value_pairs(dict_list, x)
  )

  setNames(result, names(dict_list))
}

get_key_value_pairs <- function(dict, var) {
  mod <- dict[[var]]
  mod[sapply(mod, is.null)] <- NA

  list(
    key = names(mod),
    values = unlist(mod, use.names = FALSE)
  )
}

get_labels_codebook <- function(cb) {
  purrr::discard(lapply(cb, function(x) x$label), is.null)
}

conversion <- function(mode, x) {
  switch(
    mode,
    numeric = as.numeric(x),
    character = as.character(x)
  )
}

fix_labelled_na <- function(data, vars) {
  for (var in vars) {
    data[[var]] <- labelled_na_to_na(data[[var]])
  }
  data
}

labelled_na_to_na <- function(var) {
  if (!labelled::is.labelled(var)) {
    return(var)
  }

  vals_labelled <- as.character(haven::as_factor(var, "labels"))
  var[is.na(vals_labelled)] <- NA

  labels_attr <- attr(attr(var, "labels"), "names")
  attr(var, "labels") <- attr(var, "labels")[!is.na(labels_attr)]
  var
}

check_path <- function(path) {
  if (!file.exists(path)) stop("Codebook not found. Check your file path!")
}

#' @importFrom stats na.omit
assert_no_unknown_levels <- function(data, dict, vars) {
  for (var in vars) {
    xtra <- setdiff(as.character(unique(na.omit(data[[var]]))), dict[[var]][["key"]])
    if (length(xtra) > 0) {
      stop(var, " has values in the data that aren't in the code book")
    }
  }
}

assert_mode <- function() {

}

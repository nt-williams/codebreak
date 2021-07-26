check_path <- function(path) {
  if (!file.exists(path)) stop("Codebook not found. Check your file path!")
}

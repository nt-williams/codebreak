#' R6 Class representing a codebook
#'
#' @description Decode and label data using a codebook saved as a YAML text file.
#'
#' @export
Codebook <- R6::R6Class(
  "Codebook",
  public = list(
    #' @field path Path to a YAML text file.
    path = NULL,
    #' @field codebook The codebook.
    codebook = NULL,

    #'
    #' @description
    #' Import a YAML codebook
    #'
    #' @param path The path to the YAML codebook.
    #'
    #' @return A new `Codebook` object.
    #'
    #' @examples
    #' Codebook$new(system.file("codebook.yml", package = "codebreak"))
    initialize = function(path = "codebook.yml") {
      assert_valid_path(path)

      self$path <- path.expand(path)
      raw <- yaml::read_yaml(path)

      self$codebook <- list(
        labels = get_labels_codebook(raw),
        dictionary = get_dictionary_codebook(raw)
      )
    },

    #' @description
    #' Decode data.
    #'
    #' @param data The data to decode.
    #' @param label Should column names also be renamed according to codebook labels?
    #' @param as_labelled Should the codebook be applied using the labelled package?
    #' @param .include An optional character vector of column names to
    #'  apply the codebook to.
    #' @param .exclude An optional character vector of column names to not apply
    #'  the codebook to. Ignored if \code{.include} is specified.
    #'
    #' @return An updated copy of \code{data}.
    #'
    #' @examples
    #' ex <- data.frame(
    #'   x = c(1, 2, 5, 3, 4),
    #'   y = c(0, 1, 1, 0, 1),
    #'   z = rnorm(5),
    #'   w = c(1, 1, 0, 1, 1)
    #' )
    #'
    #' cb <- Codebook$new(system.file("codebook.yml", package = "codebreak"))
    #' cb$decode(ex)
    decode = function(data, label = FALSE, as_labelled = FALSE,
                      .include = NULL, .exclude = NULL) {
      if (as_labelled) {
        return(set_labelled_labels(data, self$codebook, label, .include, .exclude))
      }

      set_codebook_labels(data, self$codebook, label, .include, .exclude)
    },

    #' @description
    #' Label data.
    #'
    #' @param data The data to label.
    #' @param as_labelled Should the codebook labels be applied using the labelled package?
    #' @param .include An optional character vector of column names to
    #'  apply the codebook to.
    #' @param .exclude An optional character vector of column names to not apply
    #'  the codebook to. Ignored if \code{.include} is specified.
    #'
    #' @importFrom stats setNames
    #'
    #' @examples
    #' ex <- data.frame(
    #'   x = c(1, 2, 5, 3, 4),
    #'   y = c(0, 1, 1, 0, 1),
    #'   z = rnorm(5),
    #'   w = c(1, 1, 0, 1, 1)
    #' )
    #' cb <- Codebook$new(system.file("codebook.yml", package = "codebreak"))
    #' cb$label(ex)
    label = function(data, as_labelled = FALSE, .include = NULL, .exclude = NULL) {
      if (as_labelled) {
        return(set_labelled_var_labels(data, self$codebook, .include, .exclude, TRUE))
      }

      set_codebook_var_labels(data, self$codebook, .include, .exclude)
    },
    print = function() {
      cat("codebook:", self$path, "\n")
      cat("\n")
      cat("decode data with `<obj>$decode()`\n")
      cat("label data with `<obj>$label()`")
    }
  ),
  cloneable = FALSE
)

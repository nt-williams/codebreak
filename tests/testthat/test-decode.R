given <-
  data.frame(
    x = c(1, 2, 5, 3, 4, 1),
    y = c(0, 1, 1, NA_real_, 1, 9),
    z = c(1.3, 4.2, 3.3, 6.78, 9.14, 5.55)
  )

test_that("basic coding works", {
  expected <-
    data.frame(
      x = c('These', 'Are', 'Labels', 'Random', 'Factor', 'These'),
      y = c('No', 'Yes', 'Yes', NA_character_, 'Yes', NA_character_),
      z = c(1.3, 4.2, 3.3, 6.78, 9.14, 5.55)
    )

  expect_equal(
    decode(given, testthat::test_path("test.yml")),
    expected
  )
})

test_that("can add labels", {
  expected <-
    data.frame(
      "Variable X" = c('These', 'Are', 'Labels', 'Random', 'Factor', 'These'),
      "Variable Y" = c('No', 'Yes', 'Yes', NA_character_, 'Yes', NA_character_),
      "Variable Z" = c(1.3, 4.2, 3.3, 6.78, 9.14, 5.55),
      check.names = FALSE
    )

  expect_equal(
    decode(given, testthat::test_path("test.yml"), label = TRUE),
    expected
  )

  expect_equal(
    label(decode(given, testthat::test_path("test.yml")),
          testthat::test_path("test.yml")),
    expected
  )
})

test_that("as_labelled working correctly, decode", {
  x <- labelled::labelled(
    c(1, 2, 5, 3, 4, 1),
    c(These = 1, Are = 2, Random = 3, Factor = 4, Labels = 5),
    "Variable X"
  )

  y <- labelled::labelled(
    c(0, 1, 1, NA, 1, NA),
    c(No = 0, Yes = 1),
    "Variable Y"
  )

  expected <-
    data.frame(
      x = x,
      y = y,
      z = c(1.3, 4.2, 3.3, 6.78, 9.14, 5.55)
    )

  expect_equal(
    decode(given,
           testthat::test_path("test.yml"),
           as_labelled = TRUE,
           label = TRUE,
           .exclude = "z"),
    expected
  )
})

test_that("as_labelled working correctly, label", {
  x <- c(1, 2, 5, 3, 4, 1)
  labelled::var_label(x) <- "Variable X"

  y <- c(0, 1, 1, NA, 1, 9)
  labelled::var_label(y) <- "Variable Y"

  expected <-
    data.frame(
      x = x,
      y = y,
      z = c(1.3, 4.2, 3.3, 6.78, 9.14, 5.55)
    )

  expect_equal(
    label(given,
          testthat::test_path("test.yml"),
          as_labelled = TRUE,
          .exclude = "z"),
    expected
  )
})

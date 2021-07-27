given <-
  data.frame(
    x = c(1, 2, 5, 3, 4),
    y = c(0, 1, 1, NA_real_, 1),
    z = c(1.3, 4.2, 3.3, 6.78, 9.14)
  )

test_that("basic coding works", {
  expected <-
    data.frame(
      x = c('These', 'Are', 'Labels', 'Random', 'Factor'),
      y = c('No', 'Yes', 'Yes', NA_character_, 'Yes'),
      z = c(1.3, 4.2, 3.3, 6.78, 9.14)
    )

  expect_equal(
    codebook(given, testthat::test_path("test.yml")),
    expected
  )
})

test_that("can add labels", {
  expected <-
    data.frame(
      "Variable X" = c('These', 'Are', 'Labels', 'Random', 'Factor'),
      "Variable Y" = c('No', 'Yes', 'Yes', NA_character_, 'Yes'),
      "Variable Z" = c(1.3, 4.2, 3.3, 6.78, 9.14),
      check.names = FALSE
    )

  expect_equal(
    codebook(given, testthat::test_path("test.yml"), .label = TRUE),
    expected
  )
})

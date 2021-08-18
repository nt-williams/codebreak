test_that("detects incorrect path", {
  expect_error(assert_valid_path(testthat::test_path("doesnt_exist.yml")))
})

test_that("stops for unknown levels", {
  bad <- data.frame(x = c(1, 2, 3, 4, 5, 6))
  expect_error(codebook(bad, testthat::test_path("test.yml")))
})


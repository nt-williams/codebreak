test_that("detects incorrect path", {
  expect_error(check_path(testthat::test_path("doesnt_exist.yml")))
})

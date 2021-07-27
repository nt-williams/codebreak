test_that("modifying correct columns", {
  .data <- data.frame(
    x = NA,
    y = NA,
    z = NA
  )

  dict <- list(x = list(), y = list(), z = list())

  expect_equal(c("x", "y", "z"), to_modify(.data, dict, NULL, NULL))
  expect_equal(c("x", "y"), to_modify(.data, dict, c("x", "y"), NULL))
  expect_equal(c("x", "y"), to_modify(.data, dict, c("x", "y"), c("x")))
  expect_equal(c("x", "y"), to_modify(.data, dict, NULL, "z"))
})

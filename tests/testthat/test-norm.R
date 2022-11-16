test_that("Test norm() function", {
  expect_equal(range(norm(vancouver_trees$height_range_id))[1], 0) # after normalization, the tibble column's range should be [0, 1]
  expect_equal(range(norm(vancouver_trees$height_range_id))[2], 1)
  expect_equal(norm(c(1, 2, 3, 4, 5)), c(0.00, 0.25, 0.50, 0.75, 1.00)) 
  expect_equal(norm(c(4, 4, 4, 4)), c(4, 4, 4, 4)) #constant vector
  expect_equal(norm(c(1, 3, NA, 5)), c(0.0, 0.5, NA, 1.0)) # vector with NA, na.rm = TRUE
  expect_equal(norm(c(1, 3, NA, 5), FALSE), c(1, 3, NA, 5)) # vector with NA, na.rm = FALSE, return original data
  expect_error(norm(list(1:5)), "This function only works for numeric vector or column.*") #list is not acceptable
  expect_error(norm(c(TRUE, TRUE, FALSE)), "This function only works for numeric vector or column.*") # unsupported vector type
})
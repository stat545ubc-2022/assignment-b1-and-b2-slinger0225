Mini Data Analysis Milestone 2
================

# Setup

Begin by loading your data and the tidyverse package below:

``` r
library(datateachr) 
library(tidyverse)
library(testthat)
```

# Exercise 1: Make a Function (25 points)

In My [Mini data analysis
Milestone1](https://github.com/stat545ubc-2022/Linger_Shen_Mini_Data_Analysis/blob/main/Milestone1/mini-project-1.Rmd#L427),
in order to investigate the relationship between neighbourhood and its
tree’s size (both its height and diameter), I would like to plot
neightbourhood name as y axis, against the *height_range_id* and
*diameter_level* side by side as x axis for easier comparison. However,
the problem is, *height_range_id* and *diameter_level* have different
range. So, we need to normalize these 2 columns to make the data in the
same range, otherwise, the heights of the side-by-side bar of
*height_range_id* and *diameter_level* might differ a lot.

There are multiple ways for normalization, I adopted the **Min-Max
Normalization** one : *(X – min(X)) / (max(X) – min(X))*.

Here is the function’s definition:

``` r
normalize <- function(data, na.rm){
  # error handling for non-numeric column
  if(!is.numeric(data)){
    stop('This function only works for numeric vector or column!\n',
         'You have provided an object of class: ', class(data)[1])
  }
  nominator <- data-min(data, na.rm = na.rm)
  denominator <- max(data, na.rm = na.rm) - min(data, na.rm = na.rm)
  normalize <- nominator/denominator
  # if all the data is the same, denominator would be 0. So, all the data will become NA. Here, we want to return the original data without normalization
  if (all(is.na(normalize))){
    return(data)
  }
  else {
    return(normalize)
  }
}
```

# Exercise 2: Document your Function (20 points)

``` r
#' @title Normalize data
#' @details
#' normalize the data using Min-Max Normalization scale
#'
#' @param data, which is the numeric data that you want to normalize, it could be a column, a vector
#' @param na.rm, specify whether you want to remove the NA data, I name it this way according to most function's convention for specifying NA processing
#' @return a normalized data, the data type is the same with your input
normalize <- function(data, na.rm){
  # error handling for non-numeric column
  if(!is.numeric(data)){
    stop('This function only works for numeric vector or column!\n',
         'You have provided an object of class: ', class(data)[1])
  }
  nominator <- data-min(data, na.rm = na.rm)
  denominator <- max(data, na.rm = na.rm) - min(data, na.rm = na.rm)
  normalize <- nominator/denominator
  # if all the data is the same, denominator would be 0. So, all the data will become NA. Here, we want to return the original data without normalization
  if (all(is.na(normalize))){
    return(data)
  }
  else {
    return(normalize)
  }
}
```

# Exercise 3: Include examples (15 points)

## Normalize a column

The first example is demonstrated using *height_range_id* and
*diameter_level* column from *vancouver_trees* dataset. The original
range of the two column is:

``` r
height_range_id_range <- range(vancouver_trees$height_range_id, na.rm = TRUE)
cat("Range of height_range_id is:[", height_range_id_range[1], ",",  height_range_id_range[2], "]")
```

    ## Range of height_range_id is:[ 0 , 10 ]

``` r
diameter_range <-range(vancouver_trees$diameter, na.rm = TRUE)
cat("Range of height_range_id is:[", diameter_range[1], ",",  diameter_range[2], "]")
```

    ## Range of height_range_id is:[ 0 , 435 ]

After normalization, as you can see below, the range of both column
becomes \[0, 1\]

``` r
height_norm <- normalize(vancouver_trees$height_range_id, na.rm = TRUE)
diameter_norm <- normalize(vancouver_trees$diameter, na.rm = TRUE)
height_norm_range <- range(height_norm, na.rm = TRUE)
cat("Range of height_range_id is:[", height_norm_range[1], ",",  height_norm_range[2], "]")
```

    ## Range of height_range_id is:[ 0 , 1 ]

``` r
diameter_norm_range <-range(diameter_norm, na.rm = TRUE)
cat("Range of height_range_id is:[", diameter_norm_range[1], ",",  diameter_norm_range[2], "]")
```

    ## Range of height_range_id is:[ 0 , 1 ]

### Error column

To calculate the normalized data, the data itself should be numeric.

In *vancouver_trees* data, *neighbourhood_name* is a character column.

``` r
head(vancouver_trees$neighbourhood_name)
```

    ## [1] "MARPOLE"                  "MARPOLE"                 
    ## [3] "KENSINGTON-CEDAR COTTAGE" "KENSINGTON-CEDAR COTTAGE"
    ## [5] "KENSINGTON-CEDAR COTTAGE" "MARPOLE"

Apply normalize() to it will produce an error:

``` r
neighbourhood_norm <- normalize(vancouver_trees$neighbourhood_name, na.rm = TRUE)
```

    ## Error in normalize(vancouver_trees$neighbourhood_name, na.rm = TRUE): This function only works for numeric vector or column!
    ## You have provided an object of class: character

## Normalize a vector

### Normal vector

``` r
data <- c(1,2,3,4)
```

After normalization, each of the data element become:

``` r
vector_norm <- normalize(data, na.rm = TRUE)
print(vector_norm)
```

    ## [1] 0.0000000 0.3333333 0.6666667 1.0000000

### Constant vector

``` r
data_constant <- c(4, 4, 4, 4)
```

Constant data can’t be normalized. According to our function’s
definition, we should return the original data:

``` r
vector_norm <- normalize(data_constant, na.rm = TRUE)
print(vector_norm)
```

    ## [1] 4 4 4 4

### Error vector

To calculate the normalized data, the data itself should be numeric.

Below is a vector contains logical data.

``` r
vector_error <- c(TRUE, TRUE, FALSE)
```

Apply normalize() to it will produce an error:

``` r
vector_error_norm <- normalize(vector_error, na.rm = TRUE)
```

    ## Error in normalize(vector_error, na.rm = TRUE): This function only works for numeric vector or column!
    ## You have provided an object of class: logical

### Vector with NA

``` r
vector_na <- c(1, 3, NA, 5)
```

Apply normalize() with `na.rm = TRUE` will remove NA value

``` r
vector_na_norm <- normalize(vector_na, na.rm = TRUE)
print(vector_na_norm)
```

    ## [1] 0.0 0.5  NA 1.0

Apply normalize() with `na.rm = FALSE` will consider NA value, then
`min(vector_na)` and `max(vector_na)` are all `NA`. It’s not possible to
calculate norm, so we will just return original data

``` r
vector_na_norm <- normalize(vector_na, na.rm = FALSE)
print(vector_na_norm)
```

    ## [1]  1  3 NA  5

## List is not acceptable

List is not acceptable when apply to `min` and `max` Below is a vector
contains logical data.

``` r
list_error <- list(1:5)
```

Apply normalize() to it will produce an error:

``` r
list_error_norm <- normalize(list_error, na.rm = TRUE)
```

    ## Error in normalize(list_error, na.rm = TRUE): This function only works for numeric vector or column!
    ## You have provided an object of class: list

# Exercise 4: Test the Function (25 points)

I added all the examples listed in Exercise 3 as test cases.

``` r
test_that("Test normalize() function", {
        expect_equal(range(normalize(vancouver_trees$height_range_id, na.rm = TRUE))[1], 0) # after normalization, the tibble column's range should be [0, 1]
        expect_equal(range(normalize(vancouver_trees$height_range_id, na.rm = TRUE))[2], 1)
        expect_equal(normalize(c(1, 2, 3, 4, 5), na.rm = TRUE), c(0.00, 0.25, 0.50, 0.75, 1.00)) 
        expect_equal(normalize(c(4, 4, 4, 4), na.rm = TRUE), c(4, 4, 4, 4)) #constant vector
        expect_equal(normalize(c(1, 3, NA, 5), na.rm = TRUE), c(0.0, 0.5, NA, 1.0)) # vector with NA, na.rm = TRUE
        expect_equal(normalize(c(1, 3, NA, 5), na.rm = FALSE), c(1, 3, NA, 5)) # vector with NA, na.rm = FALSE, return original data
        expect_error(normalize(list(1:5), na.rm = TRUE), "This function only works for numeric vector or column.*") #list is not acceptable
        expect_error(normalize(c(TRUE, TRUE, FALSE), na.rm = TRUE), "This function only works for numeric vector or column.*") # unsupported vector type
})
```

    ## Test passed 🌈

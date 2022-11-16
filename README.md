
<!-- README.md is generated from README.Rmd. Please edit that file -->

# norm

<!-- badges: start -->
<!-- badges: end -->

The goal of norm is to normalize the data using Min-Max Normalization
scale.

## Installation

You can install the development version of norm like so:

``` r
devtools::install_github("stat545ubc-2022/assignment-b1-and-b2-slinger0225", ref = "0.1.0")
```

Then, load the norm() function

``` r
library(norm)
#> 
#> 载入程辑包：'norm'
#> The following object is masked from 'package:base':
#> 
#>     norm
```

## Example

Those are basic examples which shows you how to solve a common problem:

## Normalize a column

The first example is demonstrated using *height_range_id* and
*diameter_level* column from *vancouver_trees* dataset.

After normalization, as you can see below, the range of both column
becomes \[0, 1\]

``` r
library(datateachr)
height_norm <- norm(vancouver_trees$height_range_id)
diameter_norm <- norm(vancouver_trees$diameter)
height_norm_range <- range(height_norm, na.rm = TRUE)
cat("Range of height_range_id is:[", height_norm_range[1], ",",  height_norm_range[2], "]")
#> Range of height_range_id is:[ 0 , 1 ]
diameter_norm_range <-range(diameter_norm, na.rm = TRUE)
cat("Range of height_range_id is:[", diameter_norm_range[1], ",",  diameter_norm_range[2], "]")
#> Range of height_range_id is:[ 0 , 1 ]
```

### Error column

To calculate the normalized data, the data itself should be numeric.

In *vancouver_trees* data, *neighbourhood_name* is a character column.

``` r
head(vancouver_trees$neighbourhood_name)
#> [1] "MARPOLE"                  "MARPOLE"                 
#> [3] "KENSINGTON-CEDAR COTTAGE" "KENSINGTON-CEDAR COTTAGE"
#> [5] "KENSINGTON-CEDAR COTTAGE" "MARPOLE"
```

Apply norm() to it will produce an error:

``` r
neighbourhood_norm <- norm(vancouver_trees$neighbourhood_name)
#> Error in norm(vancouver_trees$neighbourhood_name): This function only works for numeric vector or column!
#> You have provided an object of class: character
```

## Normalize a vector

### Normal vector

``` r
data <- c(1,2,3,4)
```

After normalization, each of the data element become:

``` r
vector_norm <- norm(data)
print(vector_norm)
#> [1] 0.0000000 0.3333333 0.6666667 1.0000000
```

### Constant vector

``` r
data_constant <- c(4, 4, 4, 4)
```

Constant data can’t be normalized. According to our function’s
definition, we should return the original data:

``` r
vector_norm <- norm(data_constant)
print(vector_norm)
#> [1] 4 4 4 4
```

### Vector with NA

``` r
vector_na <- c(1, 3, NA, 5)
```

The second param has a default option `na.rm = TRUE`, which removes NA
value

``` r
vector_na_norm <- norm(vector_na)
print(vector_na_norm)
#> [1] 0.0 0.5  NA 1.0
```

Apply norm() with `na.rm = FALSE` will consider NA value, then
`min(vector_na)` and `max(vector_na)` are all `NA`. It’s not possible to
calculate norm, so we will just return original data

``` r
vector_na_norm <- norm(vector_na, FALSE)
print(vector_na_norm)
#> [1]  1  3 NA  5
```

## List is not acceptable

List is not acceptable when apply to `min` and `max`

``` r
list_error <- list(1:5)
```

Apply norm() to it will produce an error:

``` r
list_error_norm <- norm(list_error)
#> Error in norm(list_error): This function only works for numeric vector or column!
#> You have provided an object of class: list
```

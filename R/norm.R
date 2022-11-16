#' @title Min Max Normalization
#' @details
#' normalize the data using Min-Max Normalization scale
#'
#' @param data, which is the numeric data that you want to normalize, it could be a column, a vector
#' @param na.rm, specify whether you want to remove the NA data, the default option is true (move the data)
#'
#' @return a normalized data, the data type is the same with your input
#' @export
#'
#' @examples
#' vector_na <- c(1, 3, NA, 5)
#' vector_na_norm <- norm(vector_na)
#' vector_na_norm <- norm(vector_na, FALSE)
norm <- function(data, na.rm = TRUE){
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

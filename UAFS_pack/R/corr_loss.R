#' Generate vector of correlations between x matrix and vector of y's
#' @param matrix, matrix of lossy data
#' @param y_vector, vector of output y's, if no y_vector input defaults to using the last column of matrix
#' @export

corr.loss <- function(matrix, y_vector=NA){
  
  if(is.na(y_vector[1])){
    y_vector <- matrix[,length(matrix[1,])]
    matrix <- matrix[,1:(length(matrix[1,])-1)]
  }
  
  n <- ncol(matrix)
  
  r_xy_vector <- numeric(0)
  
  for(i in 1:n){
    r_xy_vector <- c(r_xy_vector, cor(matrix[!is.na(matrix[,i]),i],
                                      y_vector[!is.na(matrix[,i])]))
  }
  
  return(r_xy_vector)
  
}

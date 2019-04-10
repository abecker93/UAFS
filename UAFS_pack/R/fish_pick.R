#' Pick Non-Zero Correlations in a Lossy Matrix
#' @param matrix, matrix of lossy data
#' @param y_vector, vector of output y's
#' @param alpha, default is 0.025, lower tail probability of not rejecting the null when it is indeed true (r=0)
#' @export

fish.pick <- function(matrix, y_vector, alpha=0.025){
  
  corr_vec <- corr.loss(matrix, y_vector)
  
  n <- ncol(matrix)
  if(n == 0){
    return(numeric(0))
  }
  
  counts <- numeric(0)
  
  for(i in 1:n){
    counts <- c(counts, length(matrix[!is.na(matrix[,i]),i]))
  }
  
  fish_stat <-  0.5 * log ((1+abs(corr_vec))/(1-abs(corr_vec)))
  fish_dev <- 1/sqrt(counts-3)
  
  ##using a 95% confidence interval and then picking values that are still above 0##
  
  fish_lower <- fish_stat - fish_dev * abs(qnorm(1-alpha))
  
  index <- 1:n
  
  fish_pick <- index[fish_lower>0 & !is.na(fish_lower)]
  
  return(fish_pick)
}

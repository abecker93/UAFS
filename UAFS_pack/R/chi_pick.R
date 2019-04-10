#' Pick Non-Zero Correlations in a Lossy Matrix
#' @param matrix, matrix of lossy data
#' @param y_vector, vector of output y's
#' @param alpha, default is 0.025, lower tail probability of not rejecting the null when it is indeed true (r=0)
#' @export

chi.pick <- function(matrix, y_vector, alpha=0.025){
  
  n <- ncol(matrix)
  if(n == 0){
    return(numeric(0))
  }
  p.chi <- 1:n
  
  for(i in 1:n){
    y_clean <- y_vector[!is.na(matrix[,i])]
    x_clean <- matrix[!is.na(matrix[,i]),i]
    p.chi[i] <- suppressWarnings(chisq.test(table(y_clean,x_clean))$p.value)
  }
  
  chi_picks <- (1:n)[p.chi<(alpha*2)]
  
  return(chi_picks)
}

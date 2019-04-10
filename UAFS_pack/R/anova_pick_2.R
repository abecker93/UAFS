#' Pick Non-Zero Correlations in a Lossy Matrix
#' @param matrix, matrix of lossy data
#' @param y_vector, vector of output y's
#' @param alpha, default is 0.025, lower tail probability of not rejecting the null when it is indeed true (r=0)
#' @export

anovapick.2 <- function(matrix, y_vector, alpha=0.025){
  
  n <- ncol(matrix)
  if(n == 0){
    return(numeric(0))
  }
  p.aov <- 1:n
  
  for(i in 1:n){
    y_clean <- y_vector[!is.na(matrix[,i])] #clean y vector
    x_clean <- matrix[!is.na(matrix[,i]),i] #clean x vector
    p.aov[i] <- summary(aov(y_clean~x_clean))[[1]][1,5] #calculate p_value
  }
  
  anova_picks <- (1:n)[p.aov<(alpha*2)]
  
  return(anova_picks)
}

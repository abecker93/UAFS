#' This function generates ranks, either jaccard coefficients (default) or standardized mean rank (type='standmean') for a vector of correlations (vector) over a set of confidence intervals (conf).
#' @param vector, no default, vector of correlations
#' @param matrix, lossy matrix from which the the correlations were generated
#' @param full_matrix, full matrix from which the lossy matrix was generated
#' @param y_vector, vector of y's, defaults to the last column of a matrix if either lastcol_matrix_y or lastcol_full_y is set to TRUE
#' @param conf, default=(1:99)/100. Input index of correlations as probabilities.
#' @param m, default=10 percent of total variables. Number of matches to choose, integer
#' @param type, default='jaccard'. Only other option is 'standmean'.
#' @param z, default=2, factor by which to make the set compared in jaccard coefficient larger than m. Should be an integer.
#' @param lastcol_matrix_y, default=F, TRUE/FALSE that determines if the last column of matrix is the y_vector.
#' @param lastcol_full_y, default=F, TRUE/FALSE that determines if the last column of the full_matrix is the y_vector.
#' @param keep_matches, default=F, if true will bind the matches from every round into a list with the ranks
#' @export

fish.rank <- function(vector, matrix, full_matrix, y_vector, conf=(1:99)/100,
                      m=NA,true_match=NA, type = 'jaccard', z=2, lastcol_matrix_y = F,
                      lastcol_full_y = F, keep_matches=F){

  if(lastcol_matrix_y==T){
    matrix <- matrix[,1:(length(matrix[1,])-1)]
  }

  if(lastcol_full_y==T){
    full_matrix <- full_matrix[,1:(length(full_matrix[1,])-1)]
  }

  if(is.na(m)){
    if(is.na(true_match[1])){
      m <- round(ncol(full_matrix)/10)
    }else{
      m <- length(true_match)
    }
  }

  n <- ncol(full_matrix)

  r_xy_vector_real <- numeric(0)

  for(i in 1:n){
    r_xy_vector_real <- c(r_xy_vector_real, cor(full_matrix[,i], y_vector))
  }

  z_prime <- (log(1+abs(vector))-log(1-abs(vector)))/2

  z_sd <- numeric(0)

  if(is.null(ncol(matrix))){
    z_sd <- c(z_sd, 1/sqrt(length(which(is.na(matrix)==F))-3))
  }
  else{
    for(i in 1:ncol(matrix)){
      z_sd <- c(z_sd, 1/sqrt(length(which(is.na(matrix[,i])==F))-3))
    }
  }

  ranks <- numeric(0)

  match_dat <- numeric(0)

  for(i in 1:length(conf)){

    alpha <- conf[i]

    #Lower z-intervals

    z_lower <- z_prime-z_sd*qnorm(1-((1-alpha)/2))

    #Transform back into r

    r_lower <- (exp(2*z_lower)-1)/(exp(2*z_lower)+1)

    #Find the top m predictors

    best_predictors <- match(rev(tail(sort(r_lower),m)), (r_lower))

    #Compare this to the true top m predictors

    best_predictors_true <- rank(abs(r_xy_vector_real), ties.method='first')

    match_m <- (n-(m*z)+1):n

    matches <- best_predictors_true[best_predictors]

    match_dat <- rbind(match_dat, best_predictors)

    #Using Jaccard Coefficient

    if(type=='jaccard'){

      if(is.na(true_match[1])){

        I <- length(intersect(match_m, matches))

        ranks <- c(ranks, I/(m*(z+1)-I))

      }else{
        I <- length(intersect(true_match, best_predictors))

        ranks <-c(ranks, I/(m*(z+1)-1))
      }
    }

    if(type=='standmean'){

      stopifnot(is.na(true_match[1]))

      ranks <- c(ranks, sum(matches, na.rm=T)/sum((n-m+1):n))
    }
  }
  if(keep_matches==T){
    return(list(ranks,match_dat))
  }
  else{
    return(ranks)
  }
}

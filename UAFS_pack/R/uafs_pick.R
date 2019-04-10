#' Pick significant relationships between output and columns in a data frame
#' @param data, matrix with output data
#' @param output, output variable, of type either character or numeric
#' @param alpha, default = 0.025,  lower tail probability of not rejecting the null when it is indeed true (r=0)
#' @export

uafs.pick <- function(data, output, alpha=0.025){
  if(!is.factor(output) & !is.numeric(output) & !is.integer(output)){
    warning('y_vector is not of type numeric or type factor')
  }
  n <- ncol(data)
  classes <- sapply(data, class)
  yclass <- class(output)
  all_features <- 1:n
  if(yclass=='factor'){
    numerics <- all_features[classes=='numeric']
    factors <- all_features[classes=='factor']
    anova_dat <- data[,numerics]
    chi_dat <- data[,factors]
    picks_1 <- anovapick.1(anova_dat, output, alpha)
    picks_2 <- chi.pick(chi_dat, output, alpha)
  }
  if(yclass=='numeric'|yclass=='integer'){
    numerics <- all_features[classes=='numeric']
    factors <- all_features[classes=='factor']
    fish_dat <- data[,numerics]
    anova_dat <- data[,factors]
    picks_1 <- anovapick.2(anova_dat, output, alpha)
    picks_2 <- fish.pick(fish_dat, output, alpha)
  }
  picks <- c(picks_1, picks_2)
  final_dat <- cbind(output, data[,picks])
  return(final_dat)
}
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
  
  for(i in 1:n){ #this loop converts all factors into 0-1 dummy variables if they in 'data'
    if(classes[i]=='factor'){
      levels <- length(levels(data[,i]))
      data_check <- as.numeric(data[,i])
      data_new <- numeric(0)
      for(j in 1:(levels-1)){
        data_temp <- rep(0, nrow(data))
        data_temp[data_check==j] <- 1
        data_new <- cbind(data_new, data_temp)
        colnames(data_new)[j] <- paste(colnames(data)[i],'-',j, sep='')
      }
      data <- cbind(data, data_new)
    }
  }
  
  data <- data[,-which(classes=='factor')] #remove remaining factors
  
  if(yclass=='factor' & length(levels(output))==2){ #converts binary factor outcomes into numeric
    output <- as.numeric(output)
  }
  
  n <- ncol(data)
  classes <- sapply(data, class)
  yclass <- class(output)
  
  all_features <- 1:n
  if(yclass=='factor'){ #conduct tests where the outcome is is 2+-level factor
    numerics <- all_features[classes=='numeric']
    factors <- all_features[classes=='factor']
    anova_dat <- data[,numerics]
    chi_dat <- data[,factors]
    picks_1 <- anovapick.1(anova_dat, output, alpha)
    picks_2 <- chi.pick(chi_dat, output, alpha)
  }
  if(yclass=='numeric'|yclass=='integer'){ #conduct tests between fully continuous data
    numerics <- all_features[classes=='numeric']
    fish_dat <- data[,numerics]
    picks_1 <- fish.pick(fish_dat, output, alpha)
    picks_2 <- numeric(0)
  }
  picks <- c(picks_1, picks_2)
  final_dat <- cbind(output, data[,picks])
  return(final_dat)
}
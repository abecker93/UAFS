library(devtools)
library(roxygen2)

setwd('~/Documents/research/UAFS/UAFS_pack')
document()

setwd('..')
install('UAFS_pack')


# UAFS
A set of functions for performing subset selection prior to imputation

UAFS, or Uncertainty Aware Feature Selection, is a method for performing this subset selection. A paper detailing this method is available at https://arxiv.org/pdf/1904.01385.pdf.

In order to use UAFS your data must first be prepared. To do this an outcome variable must be chosen and the the data should then be split into an outcome variable and a set of outcome features. Once this is done the function UAFS_pick can be used to select variables to be included in the imputation.


# UAFS
A set of functions for performing subset selection prior to imputation

UAFS, or Uncertainty Aware Feature Selection, is a method for performing this subset selection. A paper detailing this method is available at https://arxiv.org/pdf/1904.01385.pdf.

In order to use UAFS your data must first be prepared. To do this an outcome variable must be chosen and the the data should then be split into an outcome variable (output) and a set of features (data). Once this is done the function UAFS_pick can be used to select variables to be included in the imputation. This is done with the command uafs.pick(data, output). Additionally the alpha level to be used can be changed, with the default level being 0.025, by setting alpha in the function. The output from UAFS is the final data concatenated together which then can be fed into imputation algorithms.

In order to install UAFS, use the devtools package. The command install_github('abecker93/UAFS', subdir='UAFS_pack') should correctly install the package. If this does not work the repo can be cloned and the file UAFS_pack_build.R can be run, replacing the first setwd() command with the correct working directory that leads to the folder UAFS_pack within the package.


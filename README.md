UAFS: Uncertainty Aware Feature Selection
=========================================

This repository contains R code for UAFS, or _Uncertainty Aware Feature Selection_, a method for performing this subset selection prior to imputation. A paper detailing this method is available at https://arxiv.org/pdf/1904.01385.pdf.

### Table of Contents
- [Usage](#usage)
- [Installation](#installation)
- [Citation ](#citation)

## Usage <a name="usage"/>

In order to use UAFS your data must first be prepared. To do this an outcome variable must be chosen and the the data should then be split into an outcome variable (output) and a set of features (data). There needs to be the same number of rows in the data object as there are elements of the output, otherwise an error will be thrown. Once this is done the function UAFS_pick can be used to select variables to be included in the imputation. Additionally the alpha level to be used can be changed, with the default level being 0.025, by setting alpha in the function. The output from UAFS is the final data concatenated together which then can be fed into imputation algorithms.

In this repository there is also an example data set, example_crime_data.RData. Using this you can follow the example below.

```R
library(UAFS)
load('example_crime_data.RData')
data_for_imputation <- uafs.pick(data,output,alpha=0.025)

# the typical framework for imputation in R is MICE, and this can be fed directly into it

library(MICE)

# we use 80 imputations because in this case 80% of the data is missing

imputed_data <- mice(data_for_imputation, m=80)
```
This final step should take a while. You can reduce m in order to shorten that time. The imputed data can than be analyzed in a standard fashion for multiply imputed data. In this way UAFS can be added easily to an existing imputation framework.

## Installation <a name="installation"/>

In order to install UAFS, use the devtools package. This can be installed with the command `install.packages('devtools')` and then loaded with `library(devtools)`. The command `install_github('abecker93/UAFS', subdir='UAFS_pack')` should correctly install the package. If this does not work the repository can be cloned and the file `UAFS_pack_build.R` can be run, replacing the first `setwd()` command with the correct working directory that leads to the directory `UAFS_pack` within the package.

## Citation   <a name="citation"/>

If you use UAFS, please cite our paper:

Andrew Becker and James P. Bagrow, *UAFS: Uncertainty-Aware Feature Selection for Problems with Missing Data* (2019)
[arXiv:1904.01385](https://arxiv.org/abs/1904.01385)

Here is a BibTeX entry:
```bibtex
@article{becker2019uafs,
  title={UAFS: Uncertainty-Aware Feature Selection for Problems with Missing Data},
  author={Becker, Andrew and Bagrow, James P},
  journal={arXiv preprint arXiv:1904.01385},
  year={2019}
}
```

# Short Dataset Description

## Synopsis
We chose the Contraceptive Method Choice Data Set from the UcI Machine Learning Repository at the Center for Machine Learning and Intelligent Systems. The data set is a subset of a Contraceptive Prevalence Survey from 1987 in Indonesia. The test subjects were married women who were not pregnant or they did not know if the were pregnant.  

## Variables

The target variable is the current contraceptive method choice. The are 3 options:  

- no use  
- long-term methods  
- short-term methods  

Thus the target varibale is categorical. There are in total 9 predictor variables:

- Wife's age (numerical)
- Wife's education (categorical) 1=low, 2, 3, 4=high
- Husband's education (categorical) 1=low, 2, 3, 4=high
- Number of children ever born (numerical)
- Wife's religion (binary) 0=Non-Islam, 1=Islam
- Wife's now working? (binary) 0=Yes, 1=No
- Husband's occupation (categorical) 1, 2, 3, 4
- Standard-of-living index (categorical) 1=low, 2, 3, 4=high
- Media exposure (binary) 0=Good, 1=Not good 

## tSNE Plot

It is interesting to see if it is possible for the tSNE algorithm to separate the data in a two dimensional plane. If this is possible, then we expect a high accuracy for our classification algorithms.
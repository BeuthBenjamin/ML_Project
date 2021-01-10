# SVM Fitting Process

In this section, we will explain the fitting process for our Support Vector Machine in detail. To this end, we will first go over the details of our hyperparameter optimization. Afterwards, we briefly evaluate our results.

We use the svm function of the e1071 package.

## Hyperparameter Optimization

To fit our Support Vector Machine, we perform a hyperparameter search over all applicable parameters for each kernel.

We pick our ranges by traversing each parameter logarithmically within the reasonable direction applicable for the parameter (e.g. a negative cost is nonsensical). We additionally add 0 for cost and gamma, as well as 1/18 for gamma. 1/18 is the default value chosen by the e1071 package, it equals to 1/*dimension of data*.

Parameter | Values
--------- | ----------
Cost      | 10<sup>-1, ..., 3</sup>
Gamma     | 1/18, 10<sup>-3, ..., 0</sup> 
Degree    | 2, ..., 5
Coef0     | 10<sup>-3, ..., 3</sup>

The HPO is fitted on the training section of our previously split data and validated on the validation set. While it is seems reasonable to do K-fold validation here, we decide to use the (programmatically actually more difficult) fixed validation approach. This is mainly to reduce computational and time requirements, since our optimization space is already relatively large (after all, in the end this is but a toy example).

## Results

Kernel     | Highest Accuracy  | Cost | Gamma | Coef0 | Degree
------     | ----------------- | ---- | ----- | ----- | -----
Linear     | 0.48              | 1    | n/a   | n/a   | n/a
Radial     | 0.57              | 1000 | 0.01  | n/a   | n/a
Sigmoid    | 0.51              | 100  | 0.001 | 1.001 | n/a
Polynomial | 0.58              | 10   | 0.1   | 0.001 | 3

**Among the kernels, polynomial and radial perform best.** We can therefore assume, that the solution boundary is not linear.

Best model confusion matrix on validation data:

Prediction    |No-use| Long-term| Short-term
--------------|------|----------|-----------
No-use        |   76 |       14 |        21
Long-term     |   13 |       38 |        21
Short-term    | 38   |       17 |        56
|||
Class Total   | 127  |       69 |        98
Class Accuracy| 0.60 |      0.55|      0.57

**The model predicts all classes nearly equally well.** While there is some fluctuation within the accuracy per class, the highest distance to the mean is just 3 percent. 

**Prediction accuracy reflects total number of each class.** We can see a direct correlation between the number of samples of a class and the accuracy. The most common class, 'No-use', achieves the best accuracy, while the least common, 'Long-term', achieves the worst accuracy.

Metric | No-use | Long-term | Short-term
--- | --- | --- | ---
Sensitivity | 0.5984 | 0.5507 | 0.5714
Specificity | 0.7904 | 0.8489 | 0.7194

**The model is more specific than sensitive.** This leads to fewer false positives than false negatives.

Note: A plot for the chosen model is nonsensical. We've already proven, that t-SNE can't display our data set - trying to add a higher dimension boundary to that will only increase the noise.
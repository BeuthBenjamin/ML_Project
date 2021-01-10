# Description of the Fitting Process and Hyperparameter search

The tree was created using the R tree package. For training, the `mindev` parameter was set to 0 so that the tree would be heavily overfitted. This allows better use of pruning later. The `minsize` parameter was used as a hyperparameter for later optimization.

After the tree has been created, the total loss is calculated using the `cv.tree` function. This is done with a 10 fold cross validation over the training dataset. After this has been calculated for each node, the nodes with the lowest loss are searched. At the last node with the lowest loss the tree is then pruned. This results in the best possible generalizing tree.

To create the best possible tree, the best value for the `minsize` parameter must be found. For this purpose, 25 trees are created, with the minsize value increasing from 1. For each tree the accuracy is calculated using the validation data and at the end the `minsize` value with the highest accuracy is taken.

# Result

The tree that emerges after the previous steps contains a total of 6 terminal nodes. The optimal `minsize` value is 7. The overall accuracy of the tree based on the validation data is 52%. Since there are 3 result classes, the accuracy with random guessing would be 33%. Thus, the model has learned something and is better than the random guess. However, it's far from being good. The tree can be seen in the picture below.
![Tree](tree.png)

The distribution of the results of the validation data can be seen in the table below.

predicted     |No-use| Long-term| Short-term
--------------|------|----------|-----------
No-use        |   74 |       10 |        26
Long-term     |   22 |       38 |        29 
Short-term    | 31   |       21 |        43
|||
Class Total   |127   |       69 |        98
Class Accuracy|0.58  |      0.55|      0.43

As can be seen in the table, the No-Use and Long-Term classes have about the same prediction accuracy. Short-Term, on the other hand, has an accuracy that is more than 10% lower.


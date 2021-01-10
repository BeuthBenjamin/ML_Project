# Model Comparison

In this section we will compare our Decision Tree and SVM models based on the test split of our data. This is the only place that references the test split, all other chapters work with train and validation.

Model | Test Accuracy
--- | ---
Decision Tree | 57%
SVM | 52%

**Both models perform relatively bad.** With 56% and 52% accuracy, nearly every second prediction is wrong. This might indicate, that both models aren't complex enough to grasp the problem. Another reasonable explanation could be, that the choice of contraceptive method is more complicated and might need a larger dataset with additional features.

**SVM performs worse than expected.** Since a Support Vector Machine is a more complex model than Decision Trees, we expected SVMs to outperform the decision tree. Even with an expansive hyperparameter optimization, the SVM lags 5% behind the Decision Tree. This is curious, since usually there is an accuracy-explainability trade-off, but in this case, the more explainable model, the decision tree, wins. Possibly, the data set is just not well approximable with SVMs.

![](imgs/Accuracy-vs-Explainability.jpg)

Source: Duval, Alexandre. (2019). Explainable Artificial Intelligence (XAI). 10.13140/RG.2.2.24722.09929.

Sensitivity | No-use | Long-term | Short-term
--- | --- | --- | ---
Decision Tree   |              **0.6471**   |       0.43077 |           **0.5804**
SVM |                 0.5966  |        **0.44615**   |         0.4821

Specificity | No-use | Long-term | Short-term
--- | --- | --- | ---
Decision Tree    |             **0.7966**    |      **0.85281**  |          **0.6957**
SVM |                0.7797 |         0.79654    |        **0.6957**

Comparing sensitivity and specificity, SVMs achieve better sensitivity on `long-term` classes. This is marginally so, however. In every other case, the decision tree proves equal or better. 

## Conclusion

Since the decision tree achieves better results in nearly every regard, it is undoubtedly the better approach for this dataset among the two.

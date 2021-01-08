# Mathematical Overview of the Support Vector Machine

## Maximal-Margin Classifier

This is the most basic simplification of the support vector machine.  
Here we assume that we have a binary classification problem and two predictor
variables. Also, we assume our classification task is linearly separable.
This means, that there exists a line, which separates the total data correctly.
This raises the question: how do we find this line?  
A general line can be defined with the following equation:

![](imgs/svm/linear_equation.png) (1)

If we know the value of beta it is easy to then classify the data point: if the result of
equation (1) is positive, a point (x,y) belongs to class 1, else to class 2.

Now the question is, how do we find the best line that separates the data? 
This is solved by the following equation:

![](imgs/svm/maximin.png)

## Support Vector Classifier
However, real problems are often not linearly separable. What do we do, if the 
problem is more difficult, but still linear?  
We need to allow some points to go over the margin. To achieve this we can
introduce slack variables for every observation called epsilon.
Then we have to solve the following problem:

![](imgs/svm/svc.png)

## Support Vector Machine
Reality is sadly not often linear. An SVM tackles the problem to classify data
where a linear boundary is not sufficient. Therefore, the concept of a kernel is
introduced:
We take the data from the original space and transform it to a higher 
dimensional space. We hope to find a linear separation in the higher dimensional
space. This transformed problem is then solved with a Support Vector Classifier.
We use the following formula to transform the data:  

![](imgs/svm/svm.png)

K is the kernel function and is in our case a polynomial kernel function:  

![](imgs/svm/poly_kernel.png)

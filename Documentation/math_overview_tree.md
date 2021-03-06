# Mathematical Overview Decision Tree
Decision trees are a predictive model that function through segmenting the
predictor space into a small number of simple non-overlapping regions
$R_1,\ R_2,\ \dots,\ R_n$. For simplicity the regions have the shape of
rectangular boxes, these boxes are constructed in such a way as to minimize 
\begin{equation}
\sum_j{(1-\underset{k}{\text{max}}(p_{jk}))}
\end{equation}
the total classification error rate. Here $p_{jk}$ is the proportion of
observations in region $j$ that belong to class $k$.
The tree is build through a top-down process called recursive binary splitting.
This process starts with a single node tree, our future root. For each node we
determine a binary split for one of the attributes with a split value $s$ with
all observations then being assigned to one of the child nodes respective to if
their attribute value is less than or greater/equal to $s$. $s$ is chosen in a
way which maximally increases the purity of each of the two resulting new nodes.
Purity is a measure for all observations in a node belonging to the same class
and can be calculated by the Gini index $G_j$
\begin{equation}
G_j=\sum_k{p_{jk}(1-p_{jk})}
\end{equation}
When all observations belong to the same class the Gini index has a value of $0$,
i.e. a smaller Gini index is desirable.
This process is then repeated on each new child node and stops if either the 
resulting child nodes only contain a small number of observations or the new
split leads to an insignificant increase in purity.

An observation class can be predicted by following down the tree from the root
choosing paths according to the splitting values until ones arrives at a leaf
node. The leaf nodes correspond to our Regions $R_i$. The predicted class is
then the mode of the classes of all observations assigned to that node. A tree
generated through the above process will often be over-fitted to the training
data. A process to improve generalization is pruning which can be combined with
$K$-fold cross validation. In that we choose a random number of sub-trees with
different quantities of leaf nodes and examine their performance on different
folds of the training data set. The sub-tree with the best performance will then
be chosen as the final tree.

## the tree library i sused to construct classification and regression trees
library(tree)

## lets first use classification trees to analyze the carseats dataset. sales is a continuous variable, and so lets begin by recoding it as a binary
library(ISLR)
attach(Carseats)
High = ifelse(Sales<=8,'No','Yes')

Carseats=data.frame(Carseats,High)

## now lets use the tree() function to fit a classification tree in order to predict High using all variables but Sales
tree.carseats = tree(High~.-Sales,Carseats)
summary(tree.carseats)

## from the above, we can see that the training error rate is 9%

## now, lets plot the tree
plot(tree.carseats)
text(tree.carseats,pretty=0)

## the most important indicato rof Sales appears to be shelving location, since the first branch differentiates Good locations from Bad and Medium locations


## if we just type the name of the tree object, R prints output corresponding to each branch of the tree.
# R displays the split criterion, the numbers of obs in each branch, the deviance, the overall prediction of the branch, and the fraction of observations in that branch that take on values of Yes and No

## in order to properly evaluate the performance of a classification tree on these data, we must estimate the test error rather than simply computing the training error
## we split the observations into a training set and a test set, build the tree using the training set, and evaluate its performance on the test data
## the predict() functon can be used for this purpose
## in the case of a classification tree, the argument type = 'class' instructs R to return the actual class prediction
## this approach leads to correct predictions for around 71.5% of the locations in the test data set

set.seed(2)
train = sample(1:nrow(Carseats),200)
Carseats.test=Carseats[-train,]
High.test=High[-train]
tree.carseats=tree(High~.-Sales,Carseats,subset=train)
tree.pred=predict(tree.carseats,Carseats.test,type='class')
table(tree.pred,High.test)

## next, lets think about if pruning the tree might lead to improved results
## the function cv.tree() performs cross-validation in order to determine the optimal level of tree complexity
## cost complexity pruning is used in order to select a sequence of trees for consideration
## we use the argument FUN=prune.misclass in order to indicate that we want the classification error rate to guide the cross-validation and prunign process, rater than the default for the cv.tree() function, which is deviance
# the cv.tree() function reporst the number of terminal nodes of each tree consiered (size) as well as the corresponding error rate and the value of the cost-complexity parameter used (k)
set.seed(3)
cv.carseats=cv.tree(tree.carseats,FUN=prune.misclass)
names(cv.carseats)
cv.carseats

## looks like somewhere around 8 nodes results int he lowest cross vlaidation error rate
## but lets plot the error rate as a fucntion of both size and k
par(mfrow=c(1,2))
plot(cv.carseats$size,cv.carseats$dev,type='b')
plot(cv.carseats$k,cv.carseats$dev,type='b')

## now apply the prune_misclass() function in order to prume the tree to obtain the nine-node tree
prune.carseats=prune.misclass(tree.carseats,best=9)
plot(prune.carseats)
text(prune.carseats,pretty=0)

## how well does this pruned tree perform on the test data set?
tree.pred=predict(prune.carseats,Carseats.test,type='class')
table(tree.pred,High.test)

## we can see that we've improved the error rate from abouty 70% to around 75%-ish

## 8.3.2: fitting regression trees
#next, we fit a regression tree to the boston data set. first, we create a training set and fit the tree to the training data.
library(MASS)
train = sample(1:nrow(Boston),nrow(Boston)/2)
tree.boston=tree(medv~.,Boston, subset=train)
summary(tree.boston)

## note that the output indicates that only 5 variables have been used in constructing the tree. in the context of a regression tree, the deviance is simply the sum of square errors for the trees
plot(tree.boston)
text(tree.boston,pretty=0)

## lstat measures the share of individuals with lower socioeconomic status. the tree indicates that lower values of lstat correspond to more expensive houses.
## the tree predicts a median house price of 46.4k for larger homes in suburbs in which resisents have high socioeconomic status

## now we use cv.tree() to see whether pruning the tree will increase performance
cv.boston=cv.tree(tree.boston)
plot(cv.boston$size,cv.boston$dev,type='b')

## if we wanted to prune the tree, we could do as follows:
prune.boston=prune.tree(tree.boston,best=5)
plot(prune.boston)
text(prune.boston,pretty=0)

## lets use the unpruned tree to make predictions on the test set
yhat = predict(tree.boston,newdata=Boston[-train,])
boston.test=Boston[-train,'medv']

plot(yhat,boston.test)
abline(0,1)
mean((yhat-boston.test)^2)

## test set MSE associated with this regression tree is between 20-25. the square root of the mse is therearound around sqrt(20), indicating that this model leads to test set predictions that are within around $5k of the true median home value for the suburb


## 8.3.3: bagging and random forests
# here, we will apply bagging and random forests to the Boston data, using the randomForest package in r.
## recall, that bagging is simply a special case of random forest where m = p. therefore, the randomForest() function can be used to perform both random forests and bagging.
# we can perform bagging as follows:

library(randomForest)
set.seed(1)
bag.boston = randomForest(medv~.,data=Boston,subset=train,mtry=13,importance=TRUE)
bag.boston

## above, mtry indicates that we are using all 13 predictors for each split of the tree. aka bagging is being performed
## how well does this perform?
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
plot(yhat.bag,boston.test)
abline(0,1)
mean((yhat.bag-boston.test)^2)

## the test set MSE is about 10-13, almost half that obtained using an optimally pruned tree.
## we could change the number of trees grown by randomForest(), using the ntree argument
bag.boston = randomForest(medv~.,data=Boston,subset=train,mtry=13,ntree=25)
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)

## growing a random forest proceeds in exactly the same way, except that we use a smaller value of the mtry argument
## by default, it uses p/3 variables when building a random forest and sqrt(p) variables when building a random forest of classification trees
## here, we try mtry = 6

set.seed(1)
rf.boston = randomForest(medv~.,data=Boston,subset=train,mtry=6,importance=TRUE)
yhat.rf = predict(rf.boston,newdata=Boston[-train,])
mean((yhat.rf-boston.test)^2)

## we got another slight improvement in performance

## using the importance() function, we can view the importance of each variable
importance(rf.boston)

## two measures of variable importance are reported:
# first, variable is based upon the mean decrease of accuracy in predictions on the out of bag samples when a given variable is excluded from the model
# second, the measure of the total decrease in node impurity that results from splits over that variable, averaged over all trees.
## in the case of regression trees, the node impurity is measured by the training RSS and for classification trees by the deviance
##plots of these importances can be produced using varImpPlot()

varImpPlot(rf.boston)

## from the above, its very clear that lstat and rm are by far our most important variables 

library(MASS)
library(ISLR)

## run model
lm.fit <- lm(medv~lstat,data=Boston)

## view model
summary(lm.fit)

## look at objects stored within model
names(lm.fit)

confint(lm.fit)
coef(lm.fit)

## generate predictions for a few values of lstat with confidence intervals
predict(lm.fit, data.frame(lstat=c(5,10,15)),interval = 'confidence')

## generate predictions for a few values of lstat with confidence intervals
predict(lm.fit, data.frame(lstat=c(5,10,15)),interval = 'prediction')

##
plot(Boston$lstat,Boston$medv)
abline(lm.fit)

##
plot(predict(lm.fit),residuals(lm.fit))
plot(predict(lm.fit),rstudent(lm.fit))

################################################################ applied exercises
auto <- data.frame(Auto)
## 8a
m1 <- lm(mpg ~ horsepower, auto)
summary(m1)

## i. relationship is strong. adj r squared is .6, implying that 60% of variance in mpg can be explained with this moddel.
## relationship is negative. for every 1 unit increase in horsepower, we expect a .15 unit decrease in mpg

## predict mpg for horsepower of 98 and 100, print cis and prediction intervals
predict(m1, data.frame(horsepower = c(98,100)),interval = 'confidence')
predict(m1, data.frame(horsepower = c(98,100)),interval = 'prediction')

## plot response and predictor, use abline to displaye least squares reg line
plot(auto$horsepower,auto$mpg)
abline(m1)

## use plot function to run diagnostics. note any problems you see.

## look at linear relationship between residuals and predictions
plot(predict(m1),residuals(m1)) ## looks like we have some heteroskedasticity, as the residual term grows

## look at distribution of residuals. should be normal
hist(residuals(m1)) ## residuals might not be normally distributed

## look at leverage points
plot(hatvalues(m1))
which.max(hatvalues(m1))

influencePlot(m1, id.method="identify", main="Influence Plot", sub="Circle size is proportial to Cook's Distance" )

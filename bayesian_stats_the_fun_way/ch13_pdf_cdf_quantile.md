Chapter 13 Exercises: The PDF, CDF, and Quantile Function
================

**Question \#1:** Using the code example for plotting the PDF on page
127, plot the CDF and quantile functions.

**Answer \#1:** We can solve this by generating a range of values with
mean = 0 and sd = 1. From this, we can integrate from 5 SDs to infinity.

``` r
alpha = 300
beta = 40000-alpha

xs <- seq(0.005,0.01,by=.00001)
density <- dbeta(xs,alpha,beta)

data <- data.frame(xs,density)

ggplot(data,aes(x=xs)) + stat_ecdf()
```

![](ch13_pdf_cdf_quantile_files/figure-gfm/calc%20q1-1.png)<!-- -->

``` r
xs <- seq(.005,.01,by=0.00001)
plot(xs,dbeta(xs,alpha,beta),type='l',lwd=3)
```

![](ch13_pdf_cdf_quantile_files/figure-gfm/calc%20q1-2.png)<!-- -->

By simply looking at the distribution above, we can see that there is an
extremely low probability of a value greater than 5 SDs from the mean.
It is clear this value is nearly zero. But how close to zero is this
value? We can calculate this by integrating from 5 to positive infinity.
I’ve done this above and we can see that the probability is around
.00000008%.

-----

-----

**Question \#2:**  
Returning to the task of measuring snowfall from Chapter 10, say you
have the following measurements (in inches) of snowfall:

7.8,9.4,10.0,7.9,9.4,7.0,7.0,7.1,8.9,7.4

What is your 99.9 percent CI for the true value of snowfall?

**Answer \#2:**  
To answer this, we need to first calculate the mean and the standard
deviation from the measurements for snowfall.

``` r
x <- c(7.8, 9.4, 10.0, 7.9, 9.4, 7.0, 7.0, 7.1, 8.9, 7.4)
mean <- mean(x)
sd <- sd(x)
```

We will then define the lower and upper bound of our CIs for a 99.9%
interval. Because our distribution is symmetrical, we can take an ever
share of (1-.999) from both sides of the distribution. This can be
defined in R as:

``` r
bounds <- (1-.999)/2
lower <- bounds
upper <- 1-bounds
```

We can now use the qnorm function to find the value of the number we are
looking for at each end of our distribution.

``` r
ci_lower <- qnorm(lower,mean=mean,sd=sd)
ci_upper <- qnorm(upper,mean=mean,sd=sd)
ci <- c(ci_lower,ci_upper)

ci
```

    ## [1]  4.456062 11.923938

And there we have it\! Lets finally visualize our 99.9% CI.

``` r
data <- data.frame(value = rnorm(1000000,mean=mean,sd=sd))

ggplot(data,aes(x=value)) + geom_density() + geom_vline(xintercept=ci_lower,linetype='dashed',colour='red') + geom_vline(xintercept=ci_upper,linetype='dashed',colour='red')
```

![](ch13_pdf_cdf_quantile_files/figure-gfm/q2%20p4%20calc-1.png)<!-- -->

Chapter 5 Exercises: The Beta Distribution
================

**Question \#1:**  
You want to use the beta distribution to determine whether or not a coin
you have is a fair coin-meaning that the coin gives you heads and tails
equally. You flip the coin 10 times and get 4 heads and 6 tails. Using
the beta distribution, what is the probability that the coin will land
on heads more than 60% of the time?

**Answer \#1:**  
First, let us get a visual of the beta distribution with these
parameters (beta(4,6)).

``` r
p = seq(0,1,length=100)
plot(p,dbeta(p,4,6))
abline(v=.6)
```

![](ch5_beta_distributions_files/figure-gfm/q1%20calc-1.png)<!-- -->

To answer our question, we are strictly interested in summing the area
under the curve to the right of 0.6 in the plot above, as designated
above with the vertical line. We can do this by using the integrate
function in R.

``` r
integrate(function(x) dbeta(x,4,6),.6,1)
```

    ## 0.09935258 with absolute error < 1.1e-15

From the above, we conclude that there is about a 10% chance that the
true probability of getting heads is 60% or greater given our observed
data.

-----

-----

**Question \#2:**  
You flip the coin 10 more times and now have 9 heads and 11 tails total.
What is the probability that the coin is fair, using our definition of
fair, give or take 5 percent?

**Answer \#2:**  
We will use a similar approach to above with a few key changes. Namely,
we will update our beta distribution parameters as well as change the
interval from which we want to integrate to calculate our probability.
Lets start by visualizing our beta distribution and marking the area we
want to integrate across.

``` r
plot(p,dbeta(p,9,11))
abline(v=.45) ## 50/50 split - 5%
abline(v=.55) ## 50/50 split + 5%
```

![](ch5_beta_distributions_files/figure-gfm/q2%20calc-1.png)<!-- -->

``` r
integrate(function(x) dbeta(x,9,11),.45,.55)
```

    ## 0.30988 with absolute error < 3.4e-15

From the above, we can see that there is about a 30% chance of the
coin’s fairness (+/- 5% from 50%).

-----

-----

**Question \#3:**  
Data is the best way to become more confident in your assertions. You
flip the coin 200 more times and end up with 109 heads and 111 tails.
Now what is the probability that the coin is fair, give or take 5%?

**Answer \#4:**  
To answer this question, we will simply update the code used in Q3 with
the new values for alpha and beta.

``` r
plot(p,dbeta(p,109,111))
abline(v=.45) ## 50/50 split - 5%
abline(v=.55) ## 50/50 split + 5%
```

![](ch5_beta_distributions_files/figure-gfm/q3%20calc-1.png)<!-- -->

``` r
integrate(function(x) dbeta(x,109,111),.45,.55)
```

    ## 0.8589371 with absolute error < 9.5e-15

From the above, we can see that there is about a \~86% chance of the
coin’s fairness (+/- 5% from 50%).

Chapter 7 Exercises: Bayesian Priors with Probability Distributions
================

**Question \#1:** A friend finds a coin on the ground, flips it, and
gets six heads in a row and then one tails. Give the beta distribution
that describes this. Use integration to determine the probability that
the true rate of flipping heads is between 0.4 and 0.6, reflecting that
the coin is reasonably fair.

**Answer \#1:** First, let us plot the beta distribution of interest
(beta(1,6)). We will then integrate between 0.4 and 0.6 to calculate the
probability that the coin is reasonably fair.

``` r
p = seq(0,1,length=100)
plot(p,dbeta(p,6,1))
abline(v=.4)
abline(v=.6)
```

![](ch9_bayesian_priors_with_prob_distributions_files/figure-gfm/q1%20calc-1.png)<!-- -->

To answer our question, we are strictly interested in summing the area
under the curve to the right of 0.6 in the plot above, as designated
above with the vertical line. We can do this by using the integrate
function in R.

``` r
integrate(function(x) dbeta(x,6,1),.4,.6)
```

    ## 0.04256 with absolute error < 4.7e-16

From the above, we conclude that there is about a 4.2% probability that
the coin is reasonably fair.

-----

-----

**Question 2:** Come up with a prior probability that the coin is far.
Use a beta distribution such that there is at least a 95% chance that
the true rate of flipping heads is between 0.4 and 0.6.

**Answer 2:** To approximate the above, we need to find a beta
distribution that contains 95% of its values between 0.4 and 0.6.
Essentially, we are solving this equation:

0.95 = integrate(function(x) dbeta(x,a,b),.4,.6)

To simplify this problem a bit, I will assume a=b, as we are ultimately
interested in these two values matching. We can write a function in R to
do this.

``` r
prior_calculation <- function(heads,tails) {
  integrate(function(x) dbeta(x,heads,tails),.4,.6)
}

prior_calculation(10,10)
```

    ## 0.627816 with absolute error < 7e-15

``` r
prior_calculation(20,20)
```

    ## 0.7958827 with absolute error < 8.8e-15

``` r
prior_calculation(30,30)
```

    ## 0.880896 with absolute error < 9.8e-15

``` r
prior_calculation(40,40)
```

    ## 0.9283794 with absolute error < 1.1e-13

``` r
prior_calculation(50,50)
```

    ## 0.9561391 with absolute error < 4.1e-12

``` r
prior_calculation(60,60)
```

    ## 0.9728042 with absolute error < 7e-11

``` r
prior_calculation(48,48)
```

    ## 0.9516743 with absolute error < 2.2e-12

``` r
plot(p,dbeta(p,48,48))
```

![](ch9_bayesian_priors_with_prob_distributions_files/figure-gfm/q2%20calc-1.png)<!-- -->

In the code above, I write a simple function that takes an integer and
adds it to our already observed data. We can then manually test a few
values and arrive at a value that provides us with a beta distribution
that contains 95% of its values between 0.4 and 0.6. The resulting
distribution is beta(48,48). This distribution is plotted above.

-----

-----

**Question 3:** Now see how many more heads (with no more tails) it
would take to convince you that there is a reasonable chance that the
coin is NOT fair. In this case, lets say that this means that our belief
in the rate of the coin being between 0.4 and 0.6 drops below 0.5.

**Answer 3:** We will start with the prior distribution from above,
beta(48,48). From here, we will add ‘head’ events until the integral
from 0.4 to 0.6 is below 0.5.

``` r
prior_calculation <- function(heads) {
  integrate(function(x) dbeta(x,48+heads,48),.4,.6)
}

prior_calculation(10)
```

    ## 0.8620113 with absolute error < 1.2e-12

``` r
prior_calculation(20)
```

    ## 0.6145136 with absolute error < 3.3e-12

``` r
prior_calculation(30)
```

    ## 0.325872 with absolute error < 9.4e-12

``` r
prior_calculation(24)
```

    ## 0.4950329 with absolute error < 1.3e-11

``` r
plot(p,dbeta(p,48+24,48))
```

![](ch9_bayesian_priors_with_prob_distributions_files/figure-gfm/q3%20calc-1.png)<!-- -->

Above, we see that it would take about 24 straight heads to get us to a
point where our belief that the probability of a fair coin drops below
50%. This distribution can be modeled with the beta distribution
beta(72,48).

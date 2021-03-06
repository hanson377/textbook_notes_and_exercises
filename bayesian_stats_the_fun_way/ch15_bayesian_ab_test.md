Chapter 15 Exercises: From Parameter Estimation to Hypothesis Testing:
Building a Bayesian AB Test
================

**Question \#1:** Suppose a director of marketing with many years of
experience tells you he believes very strongly that the variant without
images (B) won’t perform any differently than the original variant. How
could you account for this in your model? Implement this change and see
how your final conclusions change as well.

**Answer \#1:** This exercise refers to a hypothetical situation
proposed earlier in the chapter. Previously, we were given the
following:

Prior: beta(3,7)  
Variant A: beta(3+36,7+114)  
Variant B: beta(3+50,7+100)

In order to account for this strongly-held prior belief, we can add more
weight to the prior distribution. While we want to maintain the ratio of
3:7 between the alpha and the beta, we can increase the volume. We can
write code to test various weights and analyze their impact on our final
findings.

``` r
prior_adj <- function(beta,trials) { ## note that we can only enter multiples of seven to maintain whole integers for the alpha value
  alpha = beta*(3/7)
  beta = beta

  var_a = rbeta(trials,36+alpha,114+beta)
  var_b = rbeta(trials,50+alpha,100+beta)
  return(sum(var_b > var_a)/trials)
}

list <- seq(7,7*100,7)

final <- data.frame()

for (i in list) {
  result <- data.frame(prob = prior_adj(i,20000))
  result$beta <- i
  final <- rbind(final,result)
}
final$alpha <- final$beta*(3/7)

ggplot(final,aes(x=alpha,y=prob)) + geom_line() + xlab('successful conversions') + ylab('probability of var b > var a')
```

![](ch15_bayesian_ab_test_files/figure-gfm/q1%20calc-1.png)<!-- -->

From the above, we can see that our expectations for the prior can, as
expected, drastically change the interpretation of our results. As we
add more weight to our prior beliefs, the probability of VarB being
greater than VarA decreases, as our expectation that the true conversion
rate is 30% overpowers the observed data\_a in both Variant A and
Variant B.

To understand this a little better, let us visualize the beta
distributions at both extremes of this line plot.

-----

-----

**Question \#2:**  
The lead designer sees your results and insists that there’s no way that
variant B should perform better with no images. She feels that you
should assume the conversion rate for variant B is closer to 20 percent
than 30 percent. Implement a solution for this and again review the
results of your analysis.

**Answer \#2:**  
To implement this, we will hold the priors for VarA at 30 and 70.
However, for VarB, we will adjust our priors to a ratio more in-line
with the lead designer’s expectations (20,80). We will then apply the
observed to these adjusted expectations and calculate the probability
that VarB is greater than VarA.

``` r
prior_a_alpha <- 30
prior_a_beta <- 70  

prior_b_alpha <- 20
prior_b_beta <- 80

trials <- 20000

var_a = rbeta(trials,36+prior_a_alpha,114+prior_a_beta)
var_b = rbeta(trials,50+prior_b_alpha,100+prior_b_beta)
sum(var_b > var_a)/trials
```

    ## [1] 0.65605

From the above, we can see that the probability that VarB is greater
than VarA has decreased from 95% to 66%. Although we are far less
confident in our conclusion than before, the odds are still in favor of
VarB. Thus, if we had to make a decision with the data given, we’d still
choose VarB.

-----

-----

**Question \#3:**  
Assume that being 95% certain means that you’re more or less ‘convinced’
of a hypothesis. Also assume that there’s no longer any limit to the
number of emails you can send in your test. If the true conversion for A
is 0.25 and for B is 0.3, explore how many samples it would take to
convince the director of marketing that B was in fact superior. Explore
the same for the lead designer. You can generate samples of conversions
with the following snippet of R:

``` r
true.rate <- 0.25
number.of.samples <- 100
results <- runif(number.of.samples) <= true.rate
```

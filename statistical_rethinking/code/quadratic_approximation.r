## below, we have some lines of code exploring how to calculate a quadratic approximation for the purposes of calculating a bayesian posterior distribution
## this is preferred to the  grid approximation method, as it is more efficient in cases where we will need to calculate models with more than one parameter

library(rethinking)

globe.qa <- quap(
    alist(
        W ~ dbinom(W+L,p), # binomial likelihood
        p ~ dunif(0,1) # uniform prior
    ),
    data = list(W=6,L=3)
)

## display summary of quadratic approximation
precis(globe.qa)

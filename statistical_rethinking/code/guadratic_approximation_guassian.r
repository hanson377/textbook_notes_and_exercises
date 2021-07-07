## in the code below, we implement a grid approximation of the pposterior distribution for a gaussian

## first, import data referenced in book
library(rethinking)


data(Howell1)
d <- Howell1
d2 <- d[d$age >= 18,]
## look only at adults height


flist <- alist(
  height ~ dnorm(mu,sigma),
  mu ~ dnorm(178,20),
  sigma ~ dunif(0,50)
)

m4.1 <- quap(flist,data=d2) ## fitting model to data

## examine posterior
precis(m4.1)

## the numbers provide guassian appromxations for each parfameters marginal distribution
## this meanas the plausability of each value of u after averaging over the plausabilities of each value of sigma

## what happens if we add a stronger prior for the standard deviation within mu?
m4.2 <- quap(
  alist(
    height ~ dnorm(mu,sigma),
    mu ~ dnorm(178,.1),
    sigma ~ dunif(0,50)
  ), data = d2
)

precis(m4.2)

## notice that the estimate for u has hardly changed but also notice that the estimate for sigma has changed quite a bit
## this is because sigma is conditioned on the fact that the mean is near 178 with no real spread


## now, how do we sample from this posterior?
## easy
post <- extract.samples(m4.1,n=10000)
post_df <- data.frame(post)

library(ggplot2)
ggplot(post_df,aes(x=mu)) + geom_density()
ggplot(post_df,aes(x=sigma)) + geom_density()

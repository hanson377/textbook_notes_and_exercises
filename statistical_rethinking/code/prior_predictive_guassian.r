## in the code below, we generate a plot to visually examine the prior we are using for our guassian

## reasonable prior for height
sample_mu <- rnorm(10000,178,20)
sample_sigma <- runif(10000,0,50)
prior_h <- rnorm(10000,sample_mu,sample_sigma)
dens(prior_h)

## unreasonable
sample_mu <- rnorm(10000,178,100) ## larger standard deviation
sample_sigma <- runif(10000,0,50)
prior_h <- rnorm(10000,sample_mu,sample_sigma)
dens(prior_h) ## the larger sd results in some observations having a negative value for height

## simple lines of code to execute grid approximation
## grid approximation is one of the easier ways to generate a posterior distribution within a bayesian framework
## while our parameters are continuous, we can provide an excellation approximatino of the continuous posterior distribution by considering only a finite grid of parameter values

## begin code

## define grid
p_grid <- seq(0,1,length.out=100)

## define prior
prior <- rep(1,100)

## compute likelihood at each value in the grid
likelihood <- dbinom(6, size=9, prob = p_grid)

# compute product of likelihood and prior
unstd.posterior <- likelihood*prior

## standardize the posterior, so it sums to 1
posterior <- unstd.posterior / sum(unstd.posterior)

## view distribution
plot(p_grid, posterior, type='b', xlab='probability of water',ylab='posterior probability')
mtext('20 points')


## say we continue tossing the globe and observe 22 touches of water after 30 tosses of the globe.
## what does the distribution look like now?


new_likelihood <- dbinom(22,30,prob=p_grid)
unstd.posterior <- new_likelihood*prior
posterior <- unstd.posterior / sum(unstd.posterior)

plot(p_grid, posterior, type='b', xlab='probability of water',ylab='posterior probability')


## we can clearly see the distribtuion for the posterior is getting thinner and taller.
## lets now say we have completed 50 tosses of the globe with 35 successes

new_likelihood <- dbinom(35,50,prob=p_grid)
unstd.posterior <- new_likelihood*prior
posterior <- unstd.posterior / sum(unstd.posterior)

plot(p_grid, posterior, type='b', xlab='probability of water',ylab='posterior probability')


## lets now alter our prior.
prior <- ifelse(p_grid < 0.6,0,1)

new_likelihood <- dbinom(35,50,prob=p_grid)
unstd.posterior <- new_likelihood*prior
posterior <- unstd.posterior / sum(unstd.posterior)

plot(p_grid, posterior, type='b', xlab='probability of water',ylab='posterior probability')

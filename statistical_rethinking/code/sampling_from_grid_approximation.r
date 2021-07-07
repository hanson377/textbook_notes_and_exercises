

## construct posterior
p_grid <- seq(0,1,length.out=1000)
prob_p <- rep(1,1000)
prob_data <- dbinom(6,9,prob=p_grid)
posterior <- prob_data*prob_p

## generate samples with 10k draws from posterior
samples <- sample(p_grid,prob=posterior,size=10000,replace=TRUE)

plot(samples)

## in the code below, we implement a grid approximation of the pposterior distribution for a gaussian

## first, import data referenced in book
library(rethinking)
data(Howell1)
d <- Howell1
d2 <- d[d$age >= 18,]
## look only at adults height


mu.list <- seq(150,160,length.out=100)
sigma.list <- seq(7,9,length.out=100)

post <- expand.grid(mu=mu.list,sigma=sigma.list)

post$LL <- sapply(1:nrow(post), function(i) sum(
  dnorm(d2$height, post$mu[i], post$sigma[i], log=TRUE)))

post$prod <- post$LL + dnorm(post$mu,178,20,TRUE) + dunif(post$sigma,0,50,TRUE)
post$prob <- exp(post$prod-max(post$prod))

## view it
contour_xyz(post$mu,post$sigma,post$prob)
image_xyz(post$mu,post$sigma,post$prob)

## sampling from posterior
sample.rows <- sample(1:nrow(post),size=10000,replace = TRUE, prob=post$prob)
sample.mu <- post$mu[sample.rows]
sample.sigma <- post$sigma[sample.rows]

plot(sample.mu,sample.sigma,cex=0.5,pch=16, col=col.alpha(rangi2,0.1))

##
PI(sample.mu)
PI(sample.sigma)

library(rethinking)
data(Howell1)
d <- Howell1
d2 <- d[d$age >= 18,]


# define average weight, x-bar
xbar <- mean(d2$weight)

#fit model

m4.3 <- quap(
  alist(
    height ~ dnorm(mu,sigma),
    mu <- a + b*(weight - xbar),
    a ~ dnorm(178,20),
    b ~ dlnorm(0,1),
    sigma ~ dunif(0,50)
  ), data=d2
)

## examine the table of marginal distributions
precis(m4.3)

## b is our slope, so we can interpret the readout to mean that 'a person 1 kg heavier is expected to be 0.9 cm taller,
## with 89% of the posterior probability laying between 0.84 and 0.97'
## since this is nowhere near zero, this is evidence that the relationship between weight and height is linear

## a is our intercept,so the above implies that our model assumes no adults are below 154 cm, with 89% of the posterior probability
## laying between 154 and 155

## now, lets examine the covariance
round(vcov(m4.3),3)
##


## now, lets lot the posterior inference against the data
plot(height ~ weight, data=d2, col=rangi2)
post <- extract.samples(m4.3)
a_map <- mean(post$a)
b_map <- mean(post$b)
curve(a_map+b_map*(x-xbar),add=TRUE)

## now, remember that the above is just one line...the best fit line...but does a poor job around visualizing
## the uncertainty around that line
## to get around this, we can plot all of the other lines implied by this model

post <- extract.samples(m4.3)
post[1:5,]

## each of these rows are a correlated random sample from teh joint posterior of all 3 parameters, using teh covariances provided by vcov(m4.3)
## the average of very many of these lines is the posterior mean line(the one plotted above)
## lets plot a bunch of these lines now

## we will run through various sizes of N to visualize how uncertainy decrease as N increases
plot_lines <- function(N) {
dN <- d2[1:N,]

mN <- quap(
  alist(
    height ~ dnorm(mu,sigma),
    mu <- a + b*(weight-mean(weight)),
    a ~ dnorm(178,20),
    b ~ dlnorm(0,1),
    sigma ~ dunif(0,50)
  ), data = dN
)

## extract 20 samples from posterior
post <- extract.samples(mN,n=20)

## display raw data and sample size
plot(dN$weight,dN$height,xlim=range(d2$weight),ylim=range(d2$height),col=rangi2,xlab='weight',ylab='height')
mtext(concat('N = ',N))

## plot lines
for (i in 1:20)
curve(post$a[i] + post$b[i]*(x-mean(dN$weight)),col=col.alpha("black",0.3),add=TRUE)
}

plot_lines(10)
plot_lines(20)
plot_lines(50)
plot_lines(100)
plot_lines(200)
plot_lines(300)


## we can also examine the distribution for predictions of any value
post <- extract.samples(m4.3)
mu_at_50 <- post$a + post$b*(50-xbar)

dens(mu_at_50,col=rangi2,lwd=2,xlab='mu|weight=50')
PI(mu_at_50,prob=0.89)

## now, we need to repeat the above calculation for every weight on the horizontal axis, not just the ones in our dataset
weight.seq <- seq(25,70,by=1)
## use linke to compute mu for each sample from the posterior and for each weight in weight.seq
mu <- link(m4.3,data=data.frame(weight=weight.seq))

plot(height~weight,d2,type='n')

for (i in 1:100)
points(weight.seq,mu[i,],pch=16,col=col.alpha(rangi2,0.1))

mu.mean <- apply(mu,2,mean)
mu.PI <- apply(mu,2,PI,prob=0.89)

#plot raw data
plot(height ~ weight, data=d2, col=col.alpha(rangi2,0.5))
lines(weight.seq,mu.mean)
shade(mu.PI,weight.seq)

## above, yo unow have what is known as the posterior prediction means and 89% intervals around them
## we wil now incorporate the standard deviation and its uncertainty as well
## what we've done so far is just use sampels from teh posterior to visualize the uncertainy in u, the linear model of teh mean

sim.height <- sim(m4.3, data=list(weight=weight.seq))
str(sim.height)

height.PI <- apply(sim.height,2,PI,prob=0.89)
## now height contains the 89% posterior prediction interval of observable heights, across the values of weight in weight.seq

## now we plot everything again

plot(height ~ weight, d2, col=col.alpha(rangi2,0.5))
lines(weight.seq,mu.mean)
shade(mu.PI, weight.seq)
shade(height.PI,weight.seq)

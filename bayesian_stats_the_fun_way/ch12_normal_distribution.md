Chapter 12 Exercises: Normal Distribution
================

**Question \#1:** What is the probability of observing a value five
sigma greater than the mean or more?

**Answer \#1:** We can solve this by generating a range of values with
mean = 0 and sd = 1. From this, we can integrate from 5 SDs to infinity.

``` r
data <- data.frame(value = rnorm(500000,mean=0,sd=1))
ggplot(data,aes(x=value)) + geom_density() + geom_vline(xintercept=5,linetype='dashed',colour='red') + xlab('Temperature') + ylab('Density')
```

![](ch12_normal_distribution_files/figure-gfm/calc%20q1-1.png)<!-- -->

``` r
integrate(function(x) dnorm(x,mean=0,sd=1),5,1000)
```

    ## 1.088346e-08 with absolute error < 2.2e-08

By simply looking at the distribution above, we can see that there is an
extremely low probability of a value greater than 5 SDs from the mean.
It is clear this value is nearly zero. But how close to zero is this
value? We can calculate this by integrating from 5 to positive infinity.
I’ve done this above and we can see that the probability is around
.00000008%.

-----

-----

**Question \#2:** A fever is any temperature greater than 100.4 degrees
fahrenheit. Given the following measurements, what is the probability
that the patient has a fever?

100, 99.8, 101, 100.5, 99.7

**Answer \#2:** To begin, lets visualize the distribution we are
examining. In the code below, I calculate the mean and the standard
deviation of the values we are given and generate 500k points from a
normal distribution with these parameters.

``` r
temp <- c(100, 99.8, 101, 100.5, 99.7)

mean = mean(temp)
sd = sd(temp)

data <- data.frame(temp = rnorm(500000,mean=mean,sd=sd))
ggplot(data,aes(x=temp)) + geom_density() + geom_vline(xintercept=100.4,linetype='dashed',colour='red') + xlab('Temperature') + ylab('Density')
```

![](ch12_normal_distribution_files/figure-gfm/q2%20calc-1.png)<!-- -->

``` r
max_value = max(data$temp)
```

Above, I have marked the point we are interested in (temp = 100.4). To
answer our question, we want to sum the area under the curve to the
right of this dashed line. This is essentially calculating the
probability that our value is 100.4 or greater.

``` r
integrate(function(x) dnorm(x,mean=mean,sd=sd),100.4,max_value)
```

    ## 0.3563506 with absolute error < 1.4e-11

From the above, we conclude that there is about a 35.6% probability that
our patient has a fever.

-----

-----

**Question \#3:**  
Suppose in Chapter 11 we tried to measure the depth of a well by timing
coin drops and got the following values: 2.5, 3, 3.5, 4, 2

The distance an object falls can be calculated (in meters) with the
following formula: distance = 1/2 x G x time^2

Where G is 9.8 m/s/s. What is the probability that the well is over 500
meters deep?

**Answer \#3:**  
To begin, lets again create a vector with our values (transformed from
time to distance). Let us then visualize the distribution.

``` r
time <- c(2.5, 3, 3.5, 4, 2)

mean = mean(time)
sd = sd(time)

data <- data.frame(time = rnorm(500000,mean=mean,sd=sd))
ggplot(data,aes(x=time)) + geom_density() + xlab('Seconds') + ylab('Density')
```

![](ch12_normal_distribution_files/figure-gfm/calc%20q3-1.png)<!-- -->

That will work. Now we will want to figure out how many seconds is \~500
meters. Using the formula above, we can write a function that will solve
this for us. Once we have the value we need, we can integrate from that
value to infinity across the distribution.

``` r
meters_to_seconds <- function(value) {
x <- seq(1,10000,.05)
meters = (1/2)*(9.8)*(x^2)

data <- data.frame(x,meters,solve=value)
data <- data %>% mutate(diff = abs(meters-solve)) %>% mutate(ranker = rank(diff)) %>% filter(ranker == 1)
seconds <- data$x
rm(data)

return(seconds)
}
seconds <- meters_to_seconds(500)
seconds
```

    ## [1] 10.1

``` r
ggplot(data,aes(x=time)) + geom_density() + geom_vline(xintercept=seconds,linetype='dashed',colour='red') + xlab('Seconds') + ylab('Density')
```

![](ch12_normal_distribution_files/figure-gfm/function%20for%20q3-1.png)<!-- -->

``` r
integrate(function(x) dnorm(x,mean=mean,sd=sd),seconds,1000)  
```

    ## 8.84316e-24 with absolute error < 1.8e-23

``` r
## note that 1000 is somewhat arbitrary here.  It is simply a rough substitute for` 'infinity'
```

From the above, we can see that it is nearly impossible that the well is
500 meters deep.

-----

-----

**Question \#4:**  
What is the probability that there is no well? By ‘no well’, we mean
that the well is \~0 meters deep.

**Answer \#4:**  
First, let us calculate how much time it would take to drop around 0
meters.

``` r
seconds <- meters_to_seconds(0)
ggplot(data,aes(x=time)) + geom_density() + geom_vline(xintercept=seconds,linetype='dashed',colour='red') + xlab('Seconds') + ylab('Density')
```

![](ch12_normal_distribution_files/figure-gfm/q4%20calc%20time-1.png)<!-- -->

``` r
integrate(function(x) dnorm(x,mean=mean,sd=sd),-1000,seconds)  
```

    ## 0.005706018 with absolute error < 3.2e-06

Theoretically, it would take somewhere between 0 and 1 second to drop a
distance of 0 meters. If we integrate from negative infinity to one, we
find that the probability that the well is 0 meters is around 0.5%. This
seems implausible and is mostly a function of our poor estimate for how
many seconds it would take a coin to drop 0 meters. Realistically, this
number is closer to zero than one, but we integrate across this entire
space.

As we lower our limits for the integration from 1 to zero, we would find
that this probability gets closer and closer to zero (although it
technically never reaches zero).

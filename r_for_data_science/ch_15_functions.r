## why we write functions
## a. you can give a function an evocative name that makes code easier to understand
## b. as requirements change, you only need to update your code in one place
## c. you eliminate the chance of making incidental mistakes when you copy and paste

## when should you write a function?
## a: whenever you've copied and pasted a block of codre more than once.
## example:
df <- tibble::tibble(
a = rnorm(10),
b = rnorm(10),
c = rnorm(10),
d = rnorm(10)
)

df$a <- (df$a-min(df$a,na.rm = TRUE))/(max(df$a,na.rm=TRUE)-min(df$a, na.rm=TRUE))
df$b <- (df$b-min(df$b,na.rm = TRUE))/(max(df$b,na.rm=TRUE)-min(df$b, na.rm=TRUE))
df$c <- (df$c-min(df$c,na.rm = TRUE))/(max(df$c,na.rm=TRUE)-min(df$c, na.rm=TRUE))
df$d <- (df$d-min(df$d,na.rm = TRUE))/(max(df$d,na.rm=TRUE)-min(df$d, na.rm=TRUE))

## we can instead write it like this
rescale01 <- function(x) {
rng <- range(x,na.rm=TRUE)
(x-rng[1])/(rng[2]-rng[1])
}

## three keys to creating a new fucntion
## 1. you need to pick a name for the function
## 2. you list the inputs to the function inside function...ex: function(x,y,z)
## 3. you place the code you have developed in the body of the function...between {}

## now, go ahead and rerun the above but with our new function

df <- tibble::tibble(
a = rnorm(10),
b = rnorm(10),
c = rnorm(10),
d = rnorm(10)
)
summary(df)
df$a <- rescale01(df$a)
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df$d <- rescale01(df$d)
summary(df)


############### exercises
## ex 1: why is TRUE a parameter within rescale01()? what would happen if x contained a single missing value and na.rm was false?
## an 1: it is true. without it, our function would fail for any sequences of numbers where we had an NA value.

## ex2: in the second variant of rescaleo1, infinite values are left unchanged. rewrite rescale01 so that -inf is mapped to 0 and inf is mapped to 1
## an 2:

x <- c(1:10,Inf,-Inf)

rescale01 <- function(x) {
x <- ifelse(x == Inf,1,x)
x <- ifelse(x == -Inf,0,x)
rng <- range(x,na.rm=TRUE)
(x-rng[1])/(rng[2]-rng[1])
}

rescale01(x)

## ex3: practice turning the following code snippets into functions. think about what each function does. what would you call it? how many arguments does it need? can you rewrite it to be more expressive or less duplicative?
## thing 1: mean(is.na(x))

## ex4: write your own functions to compute the variance and skew of a numeric vector
## answer 4:
data <- data.frame(value = rnorm(1000,mean=10,sd=6))

variance <- function(x) {
x$diff <- (x$value-mean(x$value))^2
ss2 = sum(x$diff)
var = ss2/nrow(x)
return(var)
}
variance(data)

## ex5: write both_na(), a function that takes two vectors of the same length and returns the number of positions that have an NA in both vectors
x = seq(1,1000,1)
y = seq(1,1000,1)
x <- ifelse(data$x/3 == round(data$x/3,digits=0),NA,x)
y <- ifelse(y/3 == round(y/3,digits=0),NA,y)

both_na <- function(x,y) {
data <- data.frame(x,y)
data$binary <- ifelse(is.na(data$x) == TRUE & is.na(data$y) == TRUE,1,0)
which(data$binary == 1)
}
both_na(x,y)


## exercises: multiple conditions
# q1: whats the difference between if and ifelse()? carefully read the help and construct threee examples that illustrate the key differences
## q2: write a greeting function that says 'good morning', 'good afternoon', or 'good event', depending on the time of day.

library(lubridate)

greeting <- function(x) {
x <- hour(now())
if (x >= 4 & x <= 12) {
  'good morning'
} else if (x > 12 & x <= 20) {
  'good afternoon'
} else {
  'good evening'
}
}

## q3: write a fizzbuzz function. it takes a single number as input. if the number is divisible by three, it returns fizz. if its divisible by five, it returns buzz. if its divisible by 3 and five, it returns fizzbuzz. otherwise it returns the integer
fizzer <- function(x) {
if (x/3 == round(x/3,digits=0) & x/5 == round(x/5,digits=0)) {
  print('fizzbuzz')
} else if (x/3 == round(x/3,digits=0)) {
  print('fizz')
} else if (x/5 == round(x/5,digits=0)) {
  print('buzz')
} else {
  print(x)
}
}

## function arguments:
## in general, arguments to a function fall into two categories: one set supplies the data to compute on, the other supplies arguments that control the details of the computate
## for example, in log(), the data is x and the detail is the base of the logarithm... log(100,10)
## in general, data arguments should come first. detail arguments should go on the end and usually should have defaul values.
## ex:

mean_ci <- function(x, conf = 0.95) {
se <- sd(x) / sqrt(length(x))
alpha <- 1 - conf
mean(x) + se * qnorm(c(alpha/2,1-alpha/2))
}

x <- runif(100)
mean_ci(x)
mean_ci(x,0.99) ## changed the default value here from .95 to .99

## the above is a bit wrong. if you override the default value of a detail argument, you should use the full name:
mean_ci(x,conf = 0.99)

## checking values:
## as you start to write more functions, you'll eventually get to the point where you dont remember exactly how your functon works.
## at this point, its easy to call your function with invalid inputs.
## to avoid this, it is helpful to make constraints explicit
## ex:

wt_mean <- function(x,w) {
if (length(x) != length(w)) {
  stop("'x' and 'w' must be the same length", call. = FALSE)
}
 sum(x*w)/sum(x)
}

x = rnorm(100, mean = 0, sd = 1)
y = rnorm(100, mean = 0, sd = 1)
wt_mean(x,y)

y = rnorm(200, mean = 0, sd = 1)
wt_mean(x,y)

## to test a list of conditions, you can use stopifnot(). it checks that each argument is TRUE and produces a generic message if not.
wt_mean <- function(x,w,na.rm = FALSE) {
stopifnot(is.logical(na.rm), length(na.rm) == 1)
stopifnot(length(x) == length(w))

if (na.rm) {
miss <- is.na(x) | is.na(w)
x <- x[!miss]
w <- w[!miss]
}
sum(w*x) / sum(x)
}
wt_mean(1:6,6:1,na.rm = 'foo')
wt_mean(1:6,6:1)

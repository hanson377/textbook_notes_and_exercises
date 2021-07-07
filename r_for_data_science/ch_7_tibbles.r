library(tidyverse)

## can convert dataframe to tibble with a simple command
data <- as_tibble(iris)

## you can create a new tibble from individual vectors with tibble()
tibble(
x = 1:5,
y = 1,
z = x^2+y
)

## tibble does much less than data.frame()
## never changes the type of inputs, it never changes the names of variables, and it never cereates row names
## its possible for a tibble to have column names that are not valid r variable names. for example, they might not start with a letter or they might contain unusual characters
## to refer to these variables, you need to surround them with backticks. youll also need them when referring to these variables in other plackages like ggplot2, dplyr, and tidyr
tb <- tibble(
`:)` = "smile",
` ` = "space",
`2000` = 'number'
)
tb

## another way to create a tibble is within tribble(). tribble is customized for data entry in code
tribble(
~x,~y,~z,
#--/#--/#----
"a",2,3.6,
"b",1,8.5
)
## note that the # is simply to make it clear where the header is and is optional

## tibble vs data.frame
## two main differences between a tibble and a data.frame: printing and subsetting

#printing:
# tibbles have a refined print method that shows only the first 10 rows, and all the columns that fit on screen. this makes it much easier to work with large data
## in addition to its name, each column reports its type, a nice feature borrowed from str():
tibble(
a = lubridate::now() + runif(1e3)*86400,
b = lubridate::today() + runif(1e3)*30,
c = 1:1e3,
d = runif(1e3),
e = sample(letters,1e3,replace = TRUE)
)
## tibbles are designed so that you don't accidentally overwhelm your console when you print large data frames
## but sometimes you need more output than the default display. there are a few options for this.

## first, you can explicitly print() the data frame and control the number of rows (n) and the width of the display . width = Inf will display all columns
nycflights13::flights %>% print(n = 10, width = Inf)

## you can also control the default print behavior by setting options
options(tibble.print_max = n, tibble.print_min = m)
options(tibble.width = Inf) ## always prints all columns

## SUBSETTING
df <- tibble(
x = runif(5),
y = rnorm(5)
)

df$x
df[[1]]

## interacting with older code
## some older functions dont work with tibbles. if you encounter one of these functions, use as.data.frame() to turn a tibble back to a dataframe
class(as.data.frame(tb))

## exercises
## how can you tell if an object is a tibble?
## you could print it. if it doesn't explicitly express its a tibble when you do this, it is not a tibble
print(tibble(mtcars))
print(mtcars)

## you could also call its class
class(as.data.frame(mtcars))
class(tibble(mtcars))

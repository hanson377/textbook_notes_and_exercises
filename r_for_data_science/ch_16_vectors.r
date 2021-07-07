# there are two types of vectors:
# atomic vectors: logical, integer, double, character, complex, and raw.  integer and double vecrtors are collectively known as numeric vectors
# lists: sometimes known as recursive vectors because lists can contain other lists
# chief difference between atomic vectors and lists is that atomic vectors are homogeneous, while lists can be heterogeneous.

# every vector has two key properties:
# 1. type, which can be determined with typeof()
# 2. length, which you can determine with length()

## important types of atomic vector
# 1. logical: simplest form, can take only three possible values: FALSE, TRUE, NA
# 2. numeric: integer and double vectors are known collectively  as numeric vectors in R. numbers are doubles by default. to make an integner, place a L after the number:
typeof(1)
typeof(1L)

## the distinct between integers and doubles is not usually important, but there are two important things to keep in mind:
#1. doubles are approximations, doubles represent floating point numbers that cannot always be precisely represented with a fixed amount of memory. this means that you should consider all doubles to be approximations.
# ex: what is the square root of 2?
x <- sqrt(2)^2
x
x-2
# this is common. instead of comparing floating point numbers using ==, you should use dplyr::near(), which allows for some numerical tolerance.

#2: integers have one special value, NA, while doubles ahve four, NA, NaN, Inf, -Inf. all three special values can arise during division:
c(-1,0,1)/0

# avoid using == to check for these other special values. instead, use the helper functions is.finite(), is.infinite(), and is.nan()


# character vectors
## character vectors are the most complex type of atomic vector, because each element of a character vector is a string and a string can contain an arbitrary amount of data

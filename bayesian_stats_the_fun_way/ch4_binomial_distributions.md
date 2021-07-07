Chapter 4 Exercises: Creating a Binomial Probability Distribution
================

**Question \#1:**  
What are the parameters of the binomial distribution for the probability
of rolling either a 1 or a 20 on a 20-sided die, if we roll the die 12
times?

**Answer \#1:**  
Here, we are simply defining parameters k, n, and p for the situation
described above.

n: 12  
k: 1  
p: 2/20 = 1/10

We can then use the code below to calculate the probability of this
specific event:

``` r
n = 12
k = 1
p = 1/10

probability = choose(n,k)*(p^k)*((1-p)^(n-k))
probability
```

    ## [1] 0.3765727

-----

-----

**Question \#2:**  
There are four aces in a deck of 52 cards. If you pull a card, return
the card, then reshuffle and pull a card again, how many ways can you
pull just one ace in five pulls?

**Answer \#2:**  
This is a combinatorics problem that can easily be solved with R. Since
we are reshuffling after every pull, and we are only interested in just
one ace in five pulls, our solution is found with:

choose(5,1) = 5.

-----

-----

**Question \#3:**  
For the example in question 2, what is the probability of pulling five
aces in 10 pulls?

**Answer \#3:**  
First, let us begin by defining our parameters for the binomial
distribution (k,n,p):

k = 5 (5 aces, as stated above)  
n = 10 (10 draws)  
p = p(drawing an ace) = 4/52 = 1/13

Now that our paremeters are defined, we can use to calculate a
probability in R with the same approach as Q1:

``` r
n = 10
k = 5
p = 1/13

probability = choose(n,k)*(p^k)*((1-p)^(n-k))
probability
```

    ## [1] 0.0004548553

Not surprisingly, the probability of this specific event occurring is
very low.

-----

-----

**Question \#4:**  
When you’re searching for a new job, it is always helpful to have more
than one offer on the table so you can use it for negotiations. If you
have a 1/5 probability of receiving a job offer when you interview, and
you interview with seven companies in each month, what is the
probability you’ll have at least two competing offers by the end of that
month?

**Answer \#4:**  
We can use the function pbinom() to calculate the probability of having
at least two competing offers by the end of the month. This allows us to
easily sum the probability of the outcomes where the number of job
offers is greater than 1 (meaning we have competing job offers) across
our binomial distribution.

pbinom(1,7,1/5,lower.tail = FALSE) = 0.423 = 42.3%

Note that we use lower.tail = FALSE here, as it indicates we are summing
the probabilities to the right of the event specified. If this was
false, we’d be summing the events to the left (or the probability of not
having competing job offers).

-----

-----

**Question \#5:**  
You get a bunch of recruiter emails and find out you have 25 interviews
lined up in the next month. Unfortunately, you know this will leave you
exhausted, and the probability of getting an offer will drop to 1/10 if
you’re tired. You really dont want to go on this many interviews unless
you are at least twice as likely to get at least two competing offers.
Are you more likely to get at least two offers if you go for 25
interviews or stick to just 7?

**Answer \#5:**  
From the above, we know that the probability of having at least two
offers with 7 interviews is 42.3%. We can use the same method as above
to figure out the probability of this other scenario and compare.

``` r
prob_a = pbinom(1,7,1/5,lower.tail = FALSE) ## first scenario for consideration (less interviews, higher probability)
prob_b = pbinom(1,25,1/10,lower.tail = FALSE) ## second scenarior for consideration (more interviews, smaller probability)

prob_a
```

    ## [1] 0.4232832

``` r
prob_b
```

    ## [1] 0.7287941

``` r
prob_b/2 >= prob_a ## test the idea that prob b is 2x greater than that of probability a
```

    ## [1] FALSE

``` r
prob_b/prob_a
```

    ## [1] 1.721765

From the code above, we can see that the probability of scenario a is
\~42%. The probability of scenario b is \~73%. This implies we are only
1.73x as likely to have competing job offers in scenario b compared to
scenario a, meaning we fail to satisfy the condition that scenario b’s
probability of occurrence must be 2x that of scenario a.

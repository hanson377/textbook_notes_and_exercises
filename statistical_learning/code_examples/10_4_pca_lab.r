## load data
data <- USArrests

## run pca
pr.out = prcomp(data, scale = TRUE)


## look at values returned
names(pr.out)

## look at average of each variable
pr.out$center

## look at sd of each variable
pr.out$scale

## look
pr.out$rotation

## plot the first two PCAs
biplot(pr.out,scale=0)

# Loops Functions

x <- list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
lapply(x, mean) # this will loop through the list x applying to each element the funciton mean()

x<-1:4
lapply(x, runif, min=5, max=10) #min and max are args of runif

x<- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt){elt[,1]}) 
# this anonimous function extracts the first column of the matrix

# apply
# function (X, MARGIN, FUN, ...)
# X = data/list
# margin = selets 1 for Rows and 2 for columns to apply the function 
# obs.: margin = c(1,2) apply the fuction to each cell

x<-matrix(rnorm(200), 20, 10)
apply(x, 1, sum) # == rowSums
apply(x, 2, sum) # == colSums

a<-array(rnorm(2*2*10), c(2,2,10)) # 3D matrix of 2x2x10
apply(a, c(1,2), mean)
# or
rowMeans(a, dims = 2)

# mapply is used to more than one element (X)
# function (FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE)
list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
# or simply
mapply(rep, 1:4, 4:1)

# vectorizing a function with mapply:
noise <- function(n, mean, sd){
     rnorm(n, mean, sd)
}

mapply(noise, 1:5, 1:5, 2)
# or
list(noise(1,1,2), noise(2,2,2),
     noise(3,3,2), noise(4,4,2),
     noise(5,5,2))

# tapply is used to apply a function over subsets of a vector
# function (X, INDEX, FUN = NULL, ..., default = NA, simplify = TRUE)
l<-gl(3,10) # 10 ones, 10 tows and 10 threes
x<-c(rnorm(10), runif(10), rnorm(10,1))
tapply(x, l, mean) # x and l must have same length
tapply(x, l, range)

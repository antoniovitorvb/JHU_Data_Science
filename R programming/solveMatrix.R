# this function provides 4 subfunctions that can be called by ...$get/set/getInv/setInv
# this way, we can easily manipulate the matrixes
makeCacheMatrix <- function(x = matrix()){
     inv <- NULL
     set <- function(y){ # y is an input matrix that will be cached in x
          x <<- y
          inv <<- NULL # if inv doesn't exist, it creates it and set its value to NULL
     }
     get <- function() x
     
     setInv <- function(y){
          inv <<- y
     }
     getInv <- function() inv
     
     list(set = set,
          get = get,
          setInv = setInv,
          getInv = getInv)
}

# here is where we actually calculates de inverse of the matrix
cacheSolve <- function(x, ...){
     inv <- x$getInv() # inv is attibuted with the cached matrix of x
     if (!is.null(inv)){ # if the is a cached matrix
          message("getting cached matrix")
          return(inv)
     }
     # if there isn't one, then it sets one calling from makeCacheMatrix
     m <- x$get()
     inv <- solve(m)
     x$setInv(inv)
     inv
}
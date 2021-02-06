# Combinatorics

"%A%" <- function(n, p){
     factorial(n) / factorial(n-p)
}

"%C%" <- function(n, p){
     factorial(n) / (factorial(n-p)*factorial(p))
}

# my recursive factorial
fact <- function(x){
     if (x==0) return(1)
     else return(x*fact(x-1))
}
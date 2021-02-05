# If-else condition
if (condition1){
  y <- 0
} else if (condition2){
  y <- 10
} else {
  y <-100
}


# For loop structure

x <- c("a","b", "c", "d")

for (i in 1:4){
  print(x[i])
}

for (i in seq_along(x)){
  print(x[i])
}

for (letter in x){ # similar to python
  print(letter)
}

for (i in 1:4) print(x[i])
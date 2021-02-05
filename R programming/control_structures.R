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

# Nested for loops

x <- matrix(data = 1:6, nrow = 2, ncol = 3)

for (i in seq_len(nrow(x))){
  for (j in seq_len(ncol(x))){
    print(x[i, j])
  }
}

# While loops

count <- 0
while (count < 10){ # While stops when TRUE
  print(count)
  count <- count+1
}

# Repeat, Next, Break

repeat { # infinite loop
  if (condition){
    break #stops the loop
    
  } else {
    next # skip iteration
  }
}
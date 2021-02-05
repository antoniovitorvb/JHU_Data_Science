# lexical scoping

# make.power defines the pow function and returns a function
make.power<-function(n){
    pow<-function(x){
        x^n
    }
    pow
}

cube <- make.power(3) # cube is now a function with n=3 inside its enviroment
square <- make.power(2)

# now if i call cube/square the argument will assigned to x in pow()
cube(3)
square(4)

y<-10 # out of functions this is declared on global enviroment

f<-function(x){
    y<-2
    y^2 + g(x)
}

g<-function(x){
    x*y # if this Y doesn't exists on global, 
        # it will return an error because this Y was not defined like in f()
}
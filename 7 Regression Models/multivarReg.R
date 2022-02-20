n <- 100
x <- rnorm(n); x2 <- rnorm(n); x3 <- rnorm(n)
y <- 1 + x + x2 + x3 + rnorm(n, sd = 0.1) # noise error

ey <- resid(lm(y ~ x2 + x3)) #residual
ex <- resid(lm(x ~ x2 + x3))

sum(ey * ex)/sum(ex^2) # regression to the origin estimate

coef(lm(ey ~ ex -1))
# this is equal to
coef(lm(y ~ x + x2 + x3)) #check "x"
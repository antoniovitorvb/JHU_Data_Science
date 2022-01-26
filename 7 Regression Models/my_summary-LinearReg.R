library(UsingR)
data(diamond)

y <- diamond$price ; x <- diamond$carat; n <- length(y)

beta1 <- cor(y, x) *sd(y)/sd(x)
beta0 <- mean(y) - beta1*mean(x)

e <- y - beta0 - beta1*x # residuals
sigma <- sqrt(sum(e^2)/(n-2)) # the estimate of the SD around the regression / the variability around the regression line

ssx <- sum((x-mean(x))^2) # Sum of Squares of the X's: is the numerator of the variance formula
seBeta0 <- (1/n + mean(x)^2/ssx)^.5*sigma #Standart Error for Beta0
seBeta1 <- sigma/sqrt(ssx) #Standart Error for Beta1

tBeta0 <- beta0 / seBeta0 # t statistics for hypothesis testing
tBeta1 <- beta1 / seBeta1 # t statistics for hypothesis testing

pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = F)
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = F)

coefTable <- rbind(c(beta0, seBeta0, tBeta0, pBeta0),
                   c(beta1, seBeta1, tBeta1, pBeta1))

colnames(coefTable) <- c("Estimate", "Std. Error", "t value", "P(>|t|)")
rownames(coefTable) <- c("Intercept", "x")

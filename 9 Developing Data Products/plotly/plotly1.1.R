library(plotly)

data("mtcars")

plot_ly(data = mtcars,
        x = mtcars$wt,
        y = mtcars$mpg,
        mode = "markers",
        color = as.factor(mtcars$cyl),
        size = mtcars$hp)


# 3D scatter plot
set.seed(2016-07-21)
temp <- rnorm(n = 100, mean = 30, sd = 5)
pressue <- rnorm(100)
dtime <- 1:100

plot_ly(x = temp,
        y = pressue,
        z = dtime,
        type = "scatter3d",
        mode = "markers",
        color = temp)

#==================================
data("EuStockMarkets")
head(EuStockMarkets)
stocks <- as.data.frame(EuStockMarkets)
stocks

# Heat Map
mat <- matrix(rnorm(100*100, mean = 20, sd = 20), nrow = 100, ncol = 100)
plot_ly(z = mat, type = "heatmap")

# 3D Surface
mat2 <- matrix(sort(rnorm(100*100, mean = 20, sd = 20)), 
               nrow = 100, ncol = 100)
plot_ly(z = mat2, type = "surface")





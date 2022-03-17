library(plotly)
library(dplyr)
library(tidyr)

data("mtcars")

plot_ly(data = mtcars,
        x = ~wt,
        y = ~mpg,
        mode = "markers",
        color = ~as.factor(cyl),
        size = ~hp)


# 3D scatter plot
set.seed(2016-07-21)
temp <- rnorm(n = 100, mean = 30, sd = 5)
pressure <- rnorm(100)
dtime <- 1:100

plot_ly(x = temp,
        y = pressure,
        z = dtime,
        type = "scatter3d",
        mode = "markers",
        color = temp)

# Multi Line Graph
data("EuStockMarkets")
head(EuStockMarkets)
stocks <- as.data.frame(EuStockMarkets) %>%
     gather(index, price) %>%
     mutate(time = rep(time(EuStockMarkets), 4))

plot_ly(stocks,
        x = ~time,
        y = ~price,
        color = ~index)

# Histogram 
plot_ly(x = ~precip,
        type = "histogram")

# Box Plot
data("iris")
plot_ly(iris,
        y = ~Petal.Length,
        color = ~Species,
        type = "box")

# Heat Map
mat <- matrix(rnorm(100*100, mean = 20, sd = 20), 
              nrow = 100, ncol = 100)
plot_ly(z = mat, type = "heatmap")

# 3D Surface
mat2 <- matrix(sort(rnorm(100*100, mean = 20, sd = 20)), 
               nrow = 100, ncol = 100)
plot_ly(z = mat2, type = "surface")
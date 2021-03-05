if (!require("dplyr")) {install.packages("dplyr")}
library(dplyr)

test_cran<-as_tibble(read.csv("/data/cran.csv"))

# Common approach
by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

filtered_pack_sum <- filter(pack_sum,
                            contries > 60)

result1 <- arrange(filtered_pack_sum,
                   desc(countries),
                   avg_bytes)

# Another possible approach
result2 <-
     arrange(
          filter(
               summarize(
                    group_by(cran,
                             package
                    ),
                    count = n(),
                    unique = n_distinct(ip_id),
                    countries = n_distinct(country),
                    avg_bytes = mean(size)
               ),
               countries > 60
          ),
          desc(countries),
          avg_bytes
     )

print(result2)

# Chaining
result3 <-
     cran %>%
     group_by(package) %>%
     summarize(count = n(),
               unique = n_distinct(ip_id),
               countries = n_distinct(country),
               avg_bytes = mean(size)
     ) %>%
     filter(countries > 60) %>%
     arrange(desc(countries), avg_bytes)

print(result3)

# result1 = result2 = result3

# Example of chaining

cran %>%
     select(ip_id, country, package, size) %>%
     mutate(size_mb = size / 2^20) %>%
     filter(size_mb <= 0.5) %>%
     arrange(desc(size_mb)) %>%
     print


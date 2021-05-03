if (!("stormdata" %in% ls())){
     if (!file.exists("repdata_data_StormData.csv.bz2")){
          fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
          download.file(fileURL,
                        destfile = "repdata_data_StormData.csv.bz2")
     }
     
     stormdata <- read.csv("repdata_data_StormData.csv.bz2",
                           na.strings = c("", "NA", "NULL"))
}

library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyverse)

## 1. Across the United States, which types of events 
# (as indicated in the EVTYPE variable) 
# are most harmful with respect to population health?

fatal <- aggregate(FATALITIES ~ EVTYPE,
                   data = stormdata,
                   FUN = sum) %>%
     arrange(desc(FATALITIES)) %>%
     head(10)

fatal$EVTYPE <- factor(fatal$EVTYPE,
                       levels = fatal$EVTYPE)

png("plot1.png")
ggplot(data = fatal,
       aes(x = fct_reorder(EVTYPE,
                           FATALITIES),
           y = FATALITIES)) +
     geom_col(aes(fill = EVTYPE),
              width = 0.7) +
     geom_text(aes(label = FATALITIES),
               hjust = -0.1) +
     scale_y_continuous(limits = c(0, 7000)) +
     coord_flip() +
     labs(title = "TOP 10 Event Type with greater Fatalities",
          y = "Number of Fatalities",
          x = "Event Type") +
     scale_fill_brewer(palette = "Spectral") +
     theme(legend.position = "none")
dev.off()

injury <- aggregate(INJURIES ~ EVTYPE,
                    data = stormdata,
                    FUN = sum) %>%
     arrange(desc(INJURIES)) %>%
     head(10)

injury$EVTYPE <- factor(injury$EVTYPE,
                       levels = injury$EVTYPE)

png("plot2.png")
ggplot(data = injury,
       aes(x = fct_reorder(EVTYPE,
                           INJURIES),
           y = INJURIES)) +
     geom_col(aes(fill = EVTYPE),
              width = 0.7) +
     geom_text(aes(label = INJURIES),
               hjust = -0.1) +
     scale_y_continuous(limits = c(0, 1E5)) +
     coord_flip() +
     labs(title = "TOP 10 Event Type with greater Injuries",
          y = "Number of Injuries",
          x = "Event Type") +
     scale_fill_brewer(palette = "Spectral") +
     theme(legend.position = "none")
dev.off()

## Has the impacts of Tornado events decreased over time?

worst_event <- as.character(fatal$EVTYPE[which.max(fatal$FATALITIES)])

tornado <- subset(stormdata, EVTYPE == worst_event)

tornado$BGN_DATE <- tornado$BGN_DATE %>%
     str_remove(pattern = "0:00:00") %>%
     mdy()

tornado <- mutate(tornado,
                  MONTH = month(BGN_DATE),
                  YEAR = year(BGN_DATE))

fatal_tornados_yearly <- aggregate(FATALITIES ~ YEAR,
                                   data = tornado,
                                   FUN = sum)

png("plot3.png")
ggplot(fatal_tornados_yearly,
       aes(x = YEAR,
           y = FATALITIES)) +
     geom_point(col = "blue") +
     geom_smooth(method = "lm",
                 col = "red",
                 size = 1) +
     labs(title = "Tornado Fatalities throughout the Years",
          x = "Year",
          y = "Fatalities")
dev.off()

## 2. Across the United States, which types of events 
# have the greatest economic consequences?

economy_dmg <- select(stormdata,
                      STATE, EVTYPE, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)
for(i in 1:length(economy_dmg)) {
        if (class(economy_dmg[,i]) == "character"){
                economy_dmg[,i] <- tolower(economy_dmg[,i])
        }
}

# Changing the magnitudes of Property Damages
economy_dmg$PROPDMGEXP[economy_dmg$PROPDMGEXP == "k"] <- 3
economy_dmg$PROPDMGEXP[economy_dmg$PROPDMGEXP == "m"] <- 6
economy_dmg$PROPDMGEXP[economy_dmg$PROPDMGEXP == "b"] <- 9

economy_dmg$PROPDMGEXP <- as.numeric(economy_dmg$PROPDMGEXP)
economy_dmg$PROPDMGEXP[is.na(economy_dmg$PROPDMGEXP)] <- 0

# Changing the magnitudes of Crop Damages
economy_dmg$CROPDMGEXP[economy_dmg$CROPDMGEXP == "k"] <- 3
economy_dmg$CROPDMGEXP[economy_dmg$CROPDMGEXP == "m"] <- 6
economy_dmg$CROPDMGEXP[economy_dmg$CROPDMGEXP == "b"] <- 9

economy_dmg$CROPDMGEXP <- as.numeric(economy_dmg$CROPDMGEXP)
economy_dmg$CROPDMGEXP[is.na(economy_dmg$CROPDMGEXP)] <- 0

# this will apply the exponential to its damage amount in every row
for (i in 0:9) {
        economy_dmg$PROPDMG[economy_dmg$PROPDMGEXP == i] <- economy_dmg$PROPDMG[economy_dmg$PROPDMGEXP == i] * 10^i
        
        economy_dmg$CROPDMG[economy_dmg$CROPDMGEXP == i] <- economy_dmg$CROPDMG[economy_dmg$CROPDMGEXP == i] * 10^i
}

prop_dmg <- aggregate(PROPDMG ~ EVTYPE,
                      data = economy_dmg,
                      FUN = sum) %>%
        arrange(desc(PROPDMG)) %>%
        mutate(DDMGTYPE = "property")

crop_dmg <- aggregate(CROPDMG ~ EVTYPE,
                      data = economy_dmg,
                      FUN = sum) %>%
        arrange(desc(CROPDMG)) %>%
        mutate(DDMGTYPE = "crop")

most_expensive_events <- intersect(prop_dmg[1:15, 1],
                                   crop_dmg[1:15, 1])
prop_dmg <- subset(prop_dmg,
                       EVTYPE %in% most_expensive_events)
crop_dmg <- subset(crop_dmg,
                       EVTYPE %in% most_expensive_events)

names(prop_dmg) <- c("EVTYPE", "COUNT", "DMGTYPE")
names(crop_dmg) <- c("EVTYPE", "COUNT", "DMGTYPE")

eco_dmg <- rbind(prop_dmg, crop_dmg)

png("plot4.png", width = 800)
ggplot(data = eco_dmg,
       aes(x = fct_reorder(EVTYPE,
                           COUNT),
           y = COUNT/1E6, # in millions
           fill = DMGTYPE)) +
        geom_col() +
        coord_flip() +
        labs(title = "Economic Impacts of Weather Events",
             y = "US Dollars [millions]",
             x = "Event Type",
             fill = "Damage Type")
dev.off()

## 3. Which States are most affected by weather events?
storm2 <- cbind(economy_dmg, select(stormdata,
                                    FATALITIES, INJURIES))

# number of events that happened in each State
eventcount <- aggregate(stormdata$STATE, 
                            by = list(STATE=stormdata$STATE), 
                            FUN = NROW)

states <- with(storm2,
               aggregate(list(PROPDMG, CROPDMG, FATALITIES, INJURIES),
                         by = list(STATE=stormdata$STATE),
                         FUN = sum))

states <- merge(states, eventcount,
                by = "STATE")
names(states) <- c("STATE", "PROPDMG", "CROPDMG", "FATALITIES", "INJURIES", "EVENTCOUNTS")

states <- mutate(states,
                 COST = (PROPDMG + CROPDMG)/1E9, # in millions of USD
                 HARM = (FATALITIES + INJURIES)/100)

png("economic_health_analysis.png", width = 600)
ggplot(states,
       aes(x = COST,
           y = HARM,
           size = EVENTCOUNTS,
           label = STATE)) +
        geom_point(colour = "white",
                   fill = "red",
                   shape = 21) +
        geom_text(size = 3,
                  color = "white") +
        scale_x_continuous(name = "Damage in billion US dollars", 
                           limits = c(0,150)) +
        scale_y_continuous(name = "Number of Injuries/Fatalities [hundreds]",
                           limits = c(0,200)) +
        scale_size_area(max_size = 20)
dev.off()
harm <- with(stormdata,
             aggregate(list(FATALITIES, INJURIES),
                  by = list(EVTYPE),
                  FUN = sum))
names(harm) <- c("EVTYPE", "FATALITIES", "INJURIES")
harm <- mutate(harm,
               TOTAL = FATALITIES + INJURIES) %>%
     arrange(desc(TOTAL)) %>%
     head(10)

fatal2 <- aggregate(FATALITIES ~ EVTYPE,
                   data = stormdata,
                   FUN = sum) %>%
     arrange(desc(FATALITIES)) %>%
     mutate(HARMTYPE = "fatality")

injury2 <- aggregate(INJURIES ~ EVTYPE,
                     data = stormdata,
                     FUN = sum) %>%
     arrange(desc(INJURIES)) %>%
     mutate(HARMTYPE = "injury")
most_harmful_events <- intersect(fatal2[1:15, 1], 
                                 injury2[1:15, 1])

fatal2 <-subset(fatal2, EVTYPE %in% most_harmful_events)
injury2 <-subset(injury2, EVTYPE %in% most_harmful_events)
names(injury2) <- c("EVTYPE", "COUNT", "HARMTYPE")
names(fatal2) <- c("EVTYPE", "COUNT", "HARMTYPE")
harm <- rbind(fatal2, injury2)

png("health_impacts_evtype.png", width = 800)
ggplot(data = harm,
       aes(x = fct_reorder(EVTYPE,
                           COUNT),
           y = COUNT,
           fill = HARMTYPE)) +
     geom_col() +
     coord_flip() +
     labs(title = "Impacts in Health of Weather Events",
          y = "Number of Injuries/Fatalities",
          x = "Event Type",
          fill = "Harm Type")
dev.off()
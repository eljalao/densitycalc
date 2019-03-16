
library(dplyr)
area= read.csv("regionarea.csv")
population= read.csv("population.csv")


##########By Barangay
regionnpopulation =  group_by(population, Region)
regionnpopulation = summarize(regionnpopulation, countofbarangays = n())


regionandarea = merge(x=area, y=regionnpopulation, by=c("Region"), all.y=TRUE)

populationandarea = merge(x=population, y=regionandarea, by=c("Region"), all.y=TRUE)
populationandarea$areaofbarangay = populationandarea$Area/populationandarea$countofbarangays
populationandarea$densityofbarangay = populationandarea$Population/populationandarea$areaofbarangay
populationandarea = arrange(populationandarea, desc(densityofbarangay) )
populationandarea = populationandarea[1:5, ]
write.csv(populationandarea, "brgydensities.csv")


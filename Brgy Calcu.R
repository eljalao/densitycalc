
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


##########By City
citynpopulation =  group_by(population, Region)
citynpopulation = summarize(citynpopulation, countofcities = n_distinct(CityProvince))

cityandarea = merge(x=area, y=citynpopulation, by=c("Region"), all.y=TRUE)

totalpopbycity = group_by(population, Region, CityProvince)
totalpopbycity = summarize(totalpopbycity, populationofcity = sum(Population))


populationandcityarea = merge(x=totalpopbycity, y=cityandarea, by=c("Region"), all.x=TRUE)
populationandcityarea$areaofcity = populationandcityarea$Area/populationandcityarea$countofcities
populationandcityarea$densityofcity = populationandcityarea$populationofcity/populationandcityarea$areaofcity


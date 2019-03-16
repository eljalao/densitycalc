
library(dplyr)
area= read.csv("regionarea.csv")
population= read.csv("population.csv")

##########By City
citynpopulation =  group_by(population, Region)
citynpopulation = summarize(citynpopulation, countofcities = n_distinct(CityProvince))

cityandarea = merge(x=area, y=citynpopulation, by=c("Region"), all.y=TRUE)

totalpopbycity = group_by(population, Region, CityProvince)
totalpopbycity = summarize(totalpopbycity, populationofcity = sum(Population))


populationandcityarea = merge(x=totalpopbycity, y=cityandarea, by=c("Region"), all.x=TRUE)
populationandcityarea$areaofcity = populationandcityarea$Area/populationandcityarea$countofcities
populationandcityarea$densityofcity = populationandcityarea$populationofcity/populationandcityarea$areaofcity
populationandcityarea = arrange(populationandcityarea, desc(densityofcity) )
populationandcityarea = populationandcityarea[1:5, ]
write.csv(populationandcityarea, "brgydensities.csv")

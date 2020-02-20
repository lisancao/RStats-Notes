library(tidyverse)
library(readxl)

#get info on dataset 
mortality_data <- read.csv("C:/Users/Owner/Documents/haqseq2018/life_data_sep_avg.csv")
mortality_data
data.frame(mortality_data)
is.data.frame(mortality_data)
row.names.data.frame(mortality_data)
colnames(mortality_data)
head(mortality_data)
tail(mortality_data)
summary (mortality_data)
c(mortality_data)

##Total Summary Stats (Canada wide) 
summary (mortality_data)
#By sex
gender <- (mortality_data$Sex)
gender

gendercounts <- table(mortality_data$Sex)
gendercounts
barplot.default(gendercounts, main = "Gender Counts", xlab = "gender")

avgcounts <- table(mortality_data$AVG_VALUE)
avgcounts
avgplot <- plot.default(avgcounts, main = "Annual Mortality Averages", xlab = "Year")
avgplot 
is.data.frame(avgcounts)

sort(mortality_data$GEO)
provincecounts <- table(mortality_data$GEO)
provincecounts


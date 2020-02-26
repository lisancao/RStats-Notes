library(tidyverse)
library(readxl)
library(dplyr)
library(ggplot2)
library(broom)
library(Tmisc)
library(spatial)
library(stats)
library(matrixStats)
library(gganimate)

mortality_data <- read.csv("C:/Users/Owner/Documents/haqseq2018/life_data_sep_avg.csv")
attach(mortality_data)
head(mortality_data)
mortality_data
unique(mortality_data$YEAR)
unique(mortality_data$GEO)


##Province Alberta data subsetting & filtering 
alberta_all <- subset(mortality_data, GEO== "Alberta")
alberta_all
head(alberta_all)

##include only relevant variables
relevantcolumns <- c("YEAR", "GEO", "Age_group", "Sex")
alberta_clean <- alberta_all[relevantcolumns]

##Alberta Gender Breakdown 
#male
alberta_male <- subset(alberta_all, Sex=="M")
alberta_male
head(alberta_male)

#female
alberta_female_deaths <- alberta_female
  
alberta_female <- subset(alberta_all, Sex=="F")
alberta_female
head(alberta_female)

#Female deaths by age 
plot.default(alberta_female$YEAR)
alberta_female_deaths <- subset(alberta_female, Element=="Number of deaths between age x and x+1 (dx)")
alberta_female_deaths
head(alberta_female_deaths)

alberta_fdeaths_avg <- sort.default(alberta_female_deaths$AVG_VALUE)
alberta_fdeaths_year <- sort.default(alberta_female_deaths$YEAR)

plot.default(alberta_fdeaths_avg, alberta_fdeaths_year)

##ggplot 

animate_albfdeaths <- ggplot()


theme_set(theme_bw())
set.seed(2016)
min_weight <- 0.0005
bws <- c(.25, .5, .75, 1)
x_data <- c(rnorm(n(), .5, .025))

mortality <- data_frame(x = AVG_VALUE) %>% 
  mutate(y = rnorm(n(), .5, .025))
mortality

albertafdeathplot <- ggplot(alberta_female_deaths, aes(AVG_VALUE, Age_group, size = AVG_VALUE)) +
  geom_point() + scale_x_log10()
gganimate::animate(albertafdeathplot)  

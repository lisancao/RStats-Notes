##import libraries 
library(data.table)
library(ggplot2)
library(dplyr)
library(gganimate)
library(devtools)
library(animation)

###################################
##Import dataset

##fread import 
life_data_sep_avg <- fread("C:/Users/Owner/Documents/haqseq2018/life_data_sep_avg.csv", sep = ",")

# convert data types 
life_data_sep_avg[, Age_group := as.integer(Age_group)]
life_data_sep_avg[, YEAR := as.integer(YEAR)]

##animation settings <- NOT DOING THE JOB** 
animation::ani.options(ani.width= 1000, ani.height=1000, ani.res = 1000)

###------------------------POOLED vISUALIZATIONS BY PROVINCE ----------------------------- 
### Number of survivors at age x 
##prepare data for plot 
survivordata <- life_data_sep_avg[Element == "Number of survivors at age x (lx)" & Sex %in% c("M", "F") & YEAR %in% seq(1980, 2016, 4)]
survivordata
colnames(survivordata)

##generate ggplot & gganimate 
survivorggplot <- ggplot(survivordata, aes(Age_group, AVG_VALUE, color = Sex)) + 
  geom_point(alpha = 0.6, size = 2, show.legend = TRUE) + 
  facet_wrap(~ GEO) +
  scale_x_continuous(breaks = c(0, seq(20,120,20)), limits = c(0, 120)) + 
  scale_y_continuous(breaks = c(0, seq(10000, 100000, 10000))) + 
  scale_colour_discrete() +
  # gganimate values 
  labs(titles = 'Year: {frame_time}', x = 'Age', y = 'Number of Survivors') + 
  transition_time(YEAR)+
  ease_aes('linear')


##view survivor plot 
survivorggplot 

##save the plot 
anim_save("gganimsurvivorplot.gif", animation = last_animation(), path = '~')

###Number of Deaths at age x 
##prepare data for plot 
deathdata <- life_data_sep_avg[Element == "Number of deaths between age x and x+1 (dx)" & Sex %in% c("M", "F") & YEAR %in% seq(1980, 2016, 1)]
deathdata
colnames(deathdata)

##generate ggplot & gganimate 
deathggplot <- ggplot (deathdata, aes(Age_group, AVG_VALUE, color = Sex)) +
  geom_point(alpha = 0.6, size = 2, show.legend = TRUE) + 
  facet_wrap(~ GEO) +
  scale_x_continuous(breaks = c(0, seq(20,120,20)), limits = c(0, 120)) + 
  scale_y_continuous(breaks = c(0, seq(10000, 100000, 10000))) + 
  scale_colour_discrete() +
  # gganimate values 
  labs(titles = 'Year: {frame_time}', x = 'Age', y = 'Number of Survivors') + 
  transition_time(YEAR)+
  ease_aes('linear')

##view deathggplot
deathggplot

##save the plot 
anim_save("gganimdeathplot.gif", animation = last_animation(), path = '~')

###----------------------- POOLED VISUALIZATIONS of survival BY GENDER --------------------------- 

### Number of Surviving females at age x 
##prepare data for plot 
femalesurvivordata <- life_data_sep_avg[Element == "Number of survivors at age x (lx)" & Sex %in% c("F") & YEAR %in% seq(1980, 2016, 1)]
femalesurvivordata

##generate plot 
femalesurvivalplot <- ggplot(femalesurvivordata, aes(Age_group, AVG_VALUE, color = GEO)) +
  geom_point(alpha = 0.6, size = 2, show.legend = TRUE) + 
  scale_x_continuous(breaks = c(0, seq(20,120,20)), limits = c(0, 120)) + 
  scale_y_continuous(breaks = c(0, seq(10000, 100000, 10000))) + 
  scale_color_hue()+
  labs(titles = 'Year: {frame_time}', x = 'Age', y = 'Number of Survivors') + 
  transition_time(YEAR)+
  ease_aes('linear')
#view 
femalesurvivalplot

##save the plot 
anim_save("gganimfsurvivorplot.gif", animation = last_animation(), path = '~')

### Number of Surviving males at age x 
##prepare data for plot 
malesurvivordata <- life_data_sep_avg[Element == "Number of survivors at age x (lx)" & Sex %in% c("M") & YEAR %in% seq(1980, 2016, 1)]
malesurvivordata

##generate plot 
malesurvivalplot <- ggplot(malesurvivordata, aes(Age_group, AVG_VALUE, color = GEO)) +
  geom_point(alpha = 0.6, size = 2, show.legend = TRUE) + 
  scale_x_continuous(breaks = c(0, seq(20,120,20)), limits = c(0, 120)) + 
  scale_y_continuous(breaks = c(0, seq(10000, 100000, 10000))) + 
  scale_color_hue()+
  labs(titles = 'Year: {frame_time}', x = 'Age', y = 'Number of Survivors') + 
  transition_time(YEAR)+
  ease_aes('linear')
#view 
malesurvivalplot

##save the plot 
anim_save("gganimmsurvivorplot.gif", animation = last_animation(), path = '~')

###------------------------- POOLED VISUALIZATIONS OF DEATH BY GENDER -------------------------- 
###Number of deaths for females 
##prepare the data 
femaledeathdata <- life_data_sep_avg[Element == "Number of deaths between age x and x+1 (dx)" & Sex %in% c("F") & YEAR %in% seq(1980, 2016, 1)]
femaledeathdata

##generate plot
femaledeathplot <- ggplot(femaledeathdata, aes(Age_group, AVG_VALUE, color = GEO)) +
  geom_point(alpha = 0.6, size = 2, show.legend = TRUE) + 
  scale_x_continuous(breaks = c(0, seq(20,120,20)), limits = c(0, 120)) + 
  scale_y_continuous(breaks = c(0, seq(10000, 100000, 10000))) + 
  scale_color_hue()+
  labs(titles = 'Year: {frame_time}', x = 'Age', y = 'Number of Survivors') + 
  transition_time(YEAR)+
  ease_aes('linear')

#view
femaledeathplot

##save the plot 
anim_save("gganimfemaledeathplot.gif", animation = last_animation(), path = '~')

###Number of deaths for males 
##prepare the data 
maledeathdata <- life_data_sep_avg[Element == "Number of deaths between age x and x+1 (dx)" & Sex %in% c("M") & YEAR %in% seq(1980, 2016, 1)]
maledeathdata

##generate plot 
maledeathplot <- ggplot(maledeathdata, aes(Age_group, AVG_VALUE, color = GEO)) +
  geom_point(alpha = 0.6, size = 2, show.legend = TRUE) + 
  scale_x_continuous(breaks = c(0, seq(20,120,20)), limits = c(0, 120)) + 
  scale_y_continuous(breaks = c(0, seq(10000, 100000, 10000))) + 
  scale_color_hue()+
  labs(titles = 'Year: {frame_time}', x = 'Age', y = 'Number of Survivors') + 
  transition_time(YEAR)+
  ease_aes('linear')

##view 
maledeathplot

##save the plot 
anim_save("gganimmaledeathplot.gif", animation = last_animation(), path = '~')


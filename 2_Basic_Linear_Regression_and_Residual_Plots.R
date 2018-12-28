#Linear Regression Models & Residuals 

##for each question: 
#1. scatterplot with regression line inserted, with proper labels, with units 
#2. equation of the line defining the linear relationship between y and x
#3. correlation coefficient r
#4. residual plot of residual vs. predicted or residual vs. x
#5. summarizations describing relationship (+/-, strength, slope commends, residuals)

#load libraries 
library(tidyverse)
library(dplyr)
library(data.table)
library(ggplot2)

##-----------------------------------------------------------
##Question 1
#dataset prep
grassdata <- read.csv("C:/Users/Owner/Desktop/Coursenotes/Statistics 205/Assignment 4/Data/grass is greener.csv")
grassdata<- data.table(grassdata)
head(grassdata)

#a) Make a scatterplot of how often the grass was cut or duration (days) against time, and fit the straight line 
#create linear model
lmgrass <- lm(Duration ~ Year, data = grassdata)
lmgrass
coefficients(lmgrass)
summary (lmgrass)
#generate plot
with(grassdata, plot(Year, Duration, main = "Grass is Greener Regression Plot", xlab = "Year", ylab = "Duration in Days"))
#add regression line
abline(lmgrass)

#generate residual plot
lmgrassres <- resid(lmgrass)
plot(lmgrassres, ylab = "Residuals", xlab = "Duration in Days", main = "Grass Residuals Plot")
abline(0,0)

plot(lmgrass, main = "Linear Model Fitting for Grass Data")

#get correlation coefficient
cor(grassdata$Duration, grassdata$Year)
coef(lmgrass)

##--------------------------------------------------------------------

##Question 2
pulsedata <- read.csv("C:/Users/Owner/Desktop/Coursenotes/Statistics 205/Assignment 4/Data/Pulse Data.csv")
pulsedata <- data.table(pulsedata)
head(pulsedata)

#a)
lmpulseweight <- lm(Pulse ~ Weight, data = pulsedata)
lmpulseweight
summary(lmpulseweight)
coef(lmpulseweight)
cor(pulsedata$Weight, pulsedata$Pulse)


plot(pulsedata$Weight, pulsedata$Pulse, main = "Linear Modelling of Pulse based on Weight", ylab = "Pulse (beats/min)", xlab = "Weight (lbs)")
abline(lmpulseweight)

lmpulseweightres <- resid(lmpulseweight)
plot(lmpulseweightres, main = "Pulse x Weight Residuals plot")
abline(0,0)

plot(lmpulseweight)

resid(lmpulseweight)
plot(resid(lmpulseweight))
abline(0,0)

#b) 
lmpulseheight <- lm(Pulse ~ Height, data = pulsedata)
lmpulseheight
summary(lmpulseheight)
coef(lmpulseheight)
cor(pulsedata$Height, pulsedata$Pulse)

plot(pulsedata$Height, pulsedata$Pulse, main = "Linear Modelling of Pulse based on Height", ylab = "Pulse (beats/min)", xlab = "Height (inches)")
abline(lmpulseheight)

lmpulseheightres <- resid(lmpulseheight)
plot(lmpulseheightres, main = "Pulse x Height Residuals Plot") 
abline(0,0)

plot(lmpulseheight)

#### You will notice weak relationships here. This means that there could be a lurking variable, therefore we will perform seperate analyses for each gender and see how the results differ. 

#males 
malepulsedata<- subset(pulsedata, Gender == "M")
malepulsedata

lmmalepulse <- lm(Pulse ~ Height, data = malepulsedata)
lmmalepulse
summary(lmmalepulse)
coef(lmmalepulse)
cor(malepulsedata$Height, malepulsedata$Pulse)

plot(malepulsedata$Height, malepulsedata$Pulse, main = "Linear Modelling of Male Pulse Rates x Height", ylab = "Pulse (beats/min)", xlab = "Height (inches)")
abline(lmmalepulse)

lmmalepulseres <- resid(lmmalepulse)
plot(lmmalepulseres, main = "Pulse x Height Residuals for Males")
abline(0,0)

plot(lmmalepulse)

#females 
femalepulsedata <- subset(pulsedata, Gender == "F")
head(femalepulsedata)
lmfemalepulse <- lm(Pulse ~ Height, data = femalepulsedata)
lmfemalepulse
summary(lmfemalepulse)
coef(lmfemalepulse)
cor(femalepulsedata$Height, femalepulsedata$Pulse)
plot(femalepulsedata$Height, femalepulsedata$Pulse, main = "Linear Modelling of Female Pulse Rates x Height", ylab = "Pulse (beats/min)", xlab = "Height (inches)")
abline(lmfemalepulse)
lmfemalepulseres <- resid(lmfemalepulse)
plot(lmfemalepulseres, main = "Pulse x Height Residuals for Females")
abline(0,0)
plot(lmfemalepulse)

##----------------------------------------------------------------------------
#Question 3

populationdata <- read.csv("C:/Users/Owner/Desktop/Coursenotes/Statistics 205/Assignment 4/Data/population.csv")
populationdata
plot(populationdata$Year, populationdata$Population..millions., main = "Population of growth in Europe by Year", ylab = "Population in Millions", xlab = "Year")

lmpopulation <- lm(populationdata$Population..millions. ~ populationdata$Year)
lmpopulation
plot(populationdata$Year, populationdata$Population..millions., main = "Population of growth in Europe by Year", ylab = "Population in Millions", xlab = "Year")
abline(lmpopulation)
lmpopulationres <- resid(lmpopulation)
plot(lmpopulationres, main = "Residual Model for Population Data")
abline(0,0)
plot(populationdata$Year, populationdata$Log.Population, main = "Linear Model using Log Transformation of Population", ylab = "Log of Population", xlab = "Year")
lmpoplog <- lm(populationdata$Log.Population ~ populationdata$Year)
abline(lmpoplog)

summary(lmpopulation)
cor(populationdata$Population..millions., populationdata$Year)
summary(lmpoplog)
cor(populationdata$Log.Population, populationdata$Year)

##---------------------------------------------------------------------------
#Question 5
dataa<-read.csv("C:/Users/Owner/Desktop/Coursenotes/Statistics 205/Assignment 4/Data/Anscombe DATA A.csv")
datab<-read.csv("C:/Users/Owner/Desktop/Coursenotes/Statistics 205/Assignment 4/Data/Anscombe DATA B.csv")
datac<-read.csv("C:/Users/Owner/Desktop/Coursenotes/Statistics 205/Assignment 4/Data/Anscombe DATA C.csv")
datad<-read.csv("C:/Users/Owner/Desktop/Coursenotes/Statistics 205/Assignment 4/Data/Anscombe DATA D.csv")

summary(dataa)
summary(datab)
summary(datac)
summary(datad)

##linear regression models 
lmdataa <- lm(y ~ x, data = dataa)
lmdatab <- lm(y ~ x, data = datab)
lmdatac <- lm(y ~ x, data = datac)
lmdatad <- lm(y ~ x, data = datad)

summary(lmdataa)
summary(lmdatab)
summary(lmdatac)
summary(lmdatad)

##linear regression plots
par(mfrow=c(2,2))
plot(dataa, main = "Data A")
abline(lmdataa)
plot(datab, main = "Data B")
abline(lmdatab)
plot(datac, main = "Data C")
abline(lmdatac)
plot(datad, main = "Data D")
abline(lmdatad)

##residual plots 
lmdataares <- resid(lmdataa)
plot(lmdataares, main = "Residuals for Data A")
abline(0,0)
lmdatabres <- resid(lmdatab)
plot(lmdatabres, main = "Residuals for Data B")
abline(0,0)
lmdatacres <- resid(lmdatac)
plot(lmdatacres,main = "Residuals for Data C")
abline(0,0)
lmdatadres <- resid(lmdatad)
plot(lmdatadres, main = "Residuals for Data D")
abline(0,0)
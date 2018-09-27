##Stat 205
##Assignment #1
#Due: Sep 27th, 2018
#Part one 
##1)	A phone-in poll conducted by a newspaper reported that 73% of those who called in liked business tycoon Donald Trump. 
#a)	What is the parameter of interest?
#b)	What is the statistic?

##2)	Provide two examples of nominal data and two examples of interval data.

##3) Determine the type of data for each of the following examples. i.e. is     the data categorical  (nominal or ordinal) or  interval (continuous or discrete)
#a)	Pulse rate per minute (beats/minute)
#b)	The monthly closing stock price of Royal Bank.
#c)	Your major at SFU.
#d)	Musical tastes in music.

library('readxl')
##import dataset as Pulse_Data
Pulse_Data <- read_excel("C:/Users/Owner/Desktop/Coursenotes/Fw__Stat_205_assignment_1/Pulse Data.xlsx")
##View Pulse_Data
Pulse_Data

##View Pulse_Data attributes
colnames(Pulse_Data)
row.names(Pulse_Data)

##View dataframe 
data.frame(Pulse_Data)

##Part two
#1 Using the "pulse data" set available on line, create 2 histograms. Make one using the pulse rates and the other one using weight or height as the variable. Briefly describe the shape and any features that stand out. Is the shape uni modal or bimodal, skewed  (positive or negative) or symmetric, are there any outliers? 

##Generate Pulse Histogram (Default)
Pulse_Histogram <- hist.default(Pulse_Data$Pulse, main = "Histogram for Pulse Values", xlab = "Pulse Rate")

##Generate Weight Histogram (Default)
Weight_Histogram <- hist.default(Pulse_Data$Weight, main = "Histogram for Weight", xlab = "Weight in lbs")


##2 Using the pulse data set available on line create 2 bar charts of the data.
#(Summarize your conclusions using one or two sentences)

##Generate barplot for Gender 
gendercounts <- table(Pulse_Data$Gender)
gendercounts
barplot.default(gendercounts, main = "Gender Distribution", xlab = "Gender")

##Generate barplot for Major
majorcounts <- table(Pulse_Data$Major)
majorcounts
barplot.default(majorcounts, main = "Major Distribution", xlab = "Major")


#3 Using the pulse data set available on line create 2 pie charts of the data.

##Piechart of majors 
majorcounts 
pie(majorcounts, main = "Piechart of Majors", labels = c("Arts", "Engineer", "Health", "Science"))

##Piechart of Gender
gendercounts
pie(gendercounts, main = "Piechart of Gender", labels = c("F", "M"))

##Make sure you include proper titles and labels for all charts and histograms.

##Part Three
#1) Calculate the mean, median and standard deviation of the pulse rates using the "pulse data" set on line.
summary(Pulse_Data$Pulse)
sd(Pulse_Data$Pulse)
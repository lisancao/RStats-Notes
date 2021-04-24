# dependent data LR

library(lsr)
library(tidyverse)
library(car)
library(moments)

 
excite <- read.csv("excite.csv") %>% 
  na.omit()


############### make my life easier 
excite_longer <- excite %>%
  na.omit() %>%
  pivot_longer(
    !Name, 
    names_to = "Assess", 
    values_to = "Rating")


excite_summary %>% excite_longer
  group_by(Assess) %>% 
  summarise( Mean = mean( Rating),
             Median = median( Rating),
             Variance = var( Rating),
             SD = sd( Rating),
             Min = min( Rating),
             Max = max( Rating),
             Skewness = skewness( Rating),
             Kurtosis = kurtosis( Rating),
             n = sum(!is.na( Rating))) 

####################
excite_diff <- excite %>% 
  mutate(diff = preTrailer - postTrailer)

# summary table 
excite_diff %>% 
    summarize(Mean = mean(diff),
            Median = median(diff),
            Variance = var(diff),
            SD = sd(diff),
            Min = min(diff),
            Max = max(diff),
            Skewness = skewness(diff),
            Kurtosis = kurtosis(diff),
            n = sum(!is.na(diff))) -> stats.table
  
stats.table

############### make my life easier should have done this first 
excite_longer <- excite %>%
  na.omit() %>%
  pivot_longer(
    !Name, 
    names_to = "Assess", 
    values_to = "Rating")


# Homogeneity of Variance
max(excite_summary$Variance) / min(excite_summary$Variance) < 4 # Returns TRUE
# Levene's test 
leveneTest(Rating ~ Assess, data = excite_longer) # not significant 

# homogeneity OK 

# normality 
excite_summary



# dependent samples t test
stats.table

# density 
ggplot(excite_longer, aes(Rating, fill = Assess)) + 
  geom_density(alpha = .5)

ggplot(excite_diff, aes(diff)) + 
  geom_density(alpha = .5)


# paired samples t test 
dep1 <- t.test(Rating ~ Assess, data = excite_longer, paired = TRUE)
dep1

# effect size 
cohensD(Rating ~ Assess, data = excite_longer, method = "paired")


# hypothesis stating 
# Null: Mean difference between before and after is equal to zero
# Alternative: Significant differences in mean before and after trailer

# mean of differences is 10.69, therefore we can reject the null 

# APA summary: 
# On average, the rating for the movie trailer increased from the pretrailer (M-preTrailer = 57.46, sd = 27.24) to post trailer (M-postTrailer = 68.15, sd = 31.57). The results of the dependent sampels t test concluded that the difference was statistically significant, t(12) = 2.32, p-valpe = 0.039, though not strongly. A moderate effect size observed 0.64.



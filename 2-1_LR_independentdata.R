
library(moments)
library(car)
library(sjstats)
library(tidyverse)

faces <- read.csv("faces.csv")
faces <- faces %>% 
  mutate(emo = as.factor(emo))


#1. Assume each observation is independent. Analyse the relationship between time and emotion. 

# create summary table for descriptive stats based around emo
faces %>% 
  group_by(emo) %>%
  summarize(Mean = mean(time), 
            Variance = var(time), 
            SD = sd(time),
            SE = plotrix::std.error(time),
            Min = min(time),
            Max = max(time),
            Skewness = skewness(time),
            Kurtosis = kurtosis(time),
            n = sum(!is.na(time))) -> stats.table
stats.table



# data and assumption checking: 
# homogeneity of variances between groups and normality for each population
max(stats.table$Variance) / min(stats.table$Variance) < 4 # returns true
leveneTest(time ~ emo, data = faces) # returns VERY large p-value, the test returned as not significant
# homogeneity seems to have been maintained, indicated by the variance ratio and levene's test 

# normality via density plot 
ggplot(faces, aes(x = time, fill = emo)) + geom_density(alpha = .4) + 
  geom_vline(xintercept = mean(faces$time), size = .75)

# using boxplot to visualize group means 
ggplot(faces, aes(x = emo, y = time, fill = emo)) + 
  geom_boxplot() +
  stat_summary(fun = mean, size = 3, geom = "point")

# do QQ plots
ggplot(faces, aes(sample = time, color = emo)) + 
  geom_qq() +
  geom_qq_line() + 
  facet_grid(rows = vars(emo))

# Skewness and kurtosis values are reasonable, so the normality is maintained. This is visible in our plots as well. 

# anova 
faces_aov <- aov(time ~ emo, data = faces)
Anova(faces_aov)
as.tibble(anova_stats(faces_aov))
# able to reject null

# Null and alternative hypotheses: 
# Null: No differences between emotions on time 
# Alternative: that at least one mean for emotional state is different from at least one other 


# bonferroni
pairwise.t.test(faces$time, faces$emo, p.adjust.method = "bonferroni")
# some variance is equal 



# effect sizes 
as.tibble(anova_stats(faces_aov))
# etasq = 0.595
# omegasq = 0.524
# not a large difference between the two values 

# APA style summary
# The mean time was 7.83 (SE 0.792) for the Jealous target emotion, 7.67 (SE = 0.615) for the Sad, 4.17 for the Angry (SE = 1.17), and 4.0 (SE = 0.775) for the Happy. A one way ANOVA testing for differences between these groups was able to reject the null hypothesis successfully F(3) = 9.798, p = 0.00035, and represents an effect size 0.524.




# 2. Run a multiple regression with `time` as the response variable, and emotion and level of attachment are included as predictors in a main effects only model. Remark *very* briefly upon your findings. (/3)

emo.model <- lm(time ~ emo + attachment, data = faces)
summary(emo.model)


# remarks on findings: 
# We can see that the model is significant when predicting time when the emotion is either jealous or happy, but poor at predicting in conditions when the subject is happy. Attachment is also a poor predictor of time. This model can explain 60.44% of the variability in time.  


# 3. Try incorporating an interaction between emotion and level of attachment. 


emo.model <- lm(time ~ emo * attachment, data = faces)
summary(emo.model)

# conclusion; don't include attachment in the model

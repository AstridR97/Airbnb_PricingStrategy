###########################
###########################
### REGRESSION ANALYSIS ###
###########################
###########################

# --- Libraries --- #

library(readr)
library(broom)
library(modelsummary)
library(ggplot2)

# --- Read in data --- #

sample_airbnb <- read_csv("../../gen/temp/sample_airbnb.csv")

# --- Linear Regression --- # 

# We want to investigate the effect price has on the sentiment of reviews.
# E.g., does a higher price lead to more negative reviews? 

regr <- lm(compound ~ price, data = sample_airbnb)

# Make a summary of the results, includes p-value
sum <- glance(regr)

# Save it to temp files
write_csv(sum, '../../gen/output/modelsummary.csv')

# Summary in table 
msummary(regr)

# Plot price against compound to visually check the correlation 
plot_regr <- 
  ggplot(data = sample_airbnb, aes(x = price, y = compound)) +
  geom_point(alpha = 0.3) + geom_smooth(method = "lm", se = FALSE) + pdf(NULL)

# Add title 
plot_regr + labs(title = "Effect of price on sentiment (compound)")

# Save it to output
ggsave("../../gen/output/plot_regression.pdf")
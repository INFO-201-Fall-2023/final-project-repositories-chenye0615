library(dplyr)
library(stringr)

CO2_df <- read.csv("US-carbon-emissions.csv")
wheat_df <- read.csv("US-wheat-production.csv")
wheat_df <- subset(wheat_df, Year >= 1990 & Year <= 2019)
combo_df <- full_join(wheat_df, CO2_df, by = "Year")
combo_df$wheat_production_per_capita <- round(wheat_df$Production / 1000,2)
combo_df$CO2_emission_level <- ifelse(combo_df$Metric.Tons.Per.Capita/4.8 <= 3, "low", 
                                      ifelse(combo_df$Metric.Tons.Per.Capita/4.8 <= 4, "medium", "high"))
high_df <- filter(combo_df, combo_df$CO2_emission_level == "high")
high_count <- nrow(high_df)
total_count <- nrow(select(combo_df,CO2_emission_level))
high_per <- round(high_count/total_count * 100)

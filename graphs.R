# load the packages 
library(ggvis)
library(RColorBrewer)

# set working directory
setwd("C:/Users/Annie/Documents/Work/Graphs")

# read in the data
rates <- read.csv("cpa_rates.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)

rates$cpa_code <- factor(rates$cpa_code)

rates$year <- factor(rates$year)

tt_data <- rates[,c("CPA","rate1","rate2","rate1_baseline_diff")]

# group_by clause is a cheat so that these variables are shown on the tooltip
scatter.ggvis <- rates %>%
  group_by(CPA, year, rate1, rate2, rate1_baseline_diff) %>%
  ggvis(x = ~year, y = ~rate1_baseline_diff, fill = ~rate1_baseline_diff) %>%
  layer_points() %>%
  scale_numeric("fill", range = c("yellow", "green")) %>%
  add_tooltip(function(tt_data){
    paste0(names(tt_data), ": ", format(tt_data), collapse = "<br />")
    }, "hover")

scatter.ggvis


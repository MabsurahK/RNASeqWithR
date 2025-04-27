# install required packages
install.packages(c("tidyverse", "ggoubr", "openxlsx", "ggplot2"))
BiocManager::install(c("GEOquery", "TCGAbiolinks", "DESeq2", "airway"))
install.packages("ggpubr")


# load required packages
library(tidyverse)
library(GEOquery)
library(ggpubr)
library(openxlsx)
library(naniar)
library(dplyr)

# data import
data <- read.csv("data/GSE183947_fpkm.csv")

# data manipulation
head(data)
head(data, 10)
head(data, n=10)

tail(data)
tail(data, 10)
tail(data, n=10)

dim(data)
ncol(data)
nrow(data)
names(data)

# data sampling
sample(data)
sample_n(data, 100)
sample_frac(data, 0.25)

# find missing data
is.na(data)
sum(is.na(data))
miss_var_summary(data)
gg_miss_var(data)
miss_var_which(data)

# select data
select(data, 1)
select(data, c(1, 3, 5))
select(data, 1:3)
select(data, X)
select(data, X, CA.102548)

# filter data
filter(data, X == "FGR")
filter(data, CA.102548 > 30)
filter(data, CA.102548 < 30)
filter(data, CA.102548 >= 30)
filter(data, CA.102548 <= 30)
filter(data, X == "FGR" & CA.102548 > 30)
filter(data, X == "FGR" | CA.102548 > 30)

# chaining method
data |>
  select(X, CA.102548) |>
  filter(X == "FGR") |>
  head()

data |> 
  filter(X %in% c("CFH", "FUCA2", "GCLC","NFYA")) |> 
  head()

# mutate
data |> 
  mutate(CA.102548_Ex = log(CA.102548)) |> 
  head()

data |> 
  filter(X == "AAAS" | X == "AACS") |> 
  group_by_(CA.102548, CA.1044338) |>
  summarise(mean_CA.2006047 = mean(CA.2006047))

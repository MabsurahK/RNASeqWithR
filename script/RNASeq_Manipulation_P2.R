# load required packages
library(tidyverse)
library(GEOquery)
library(ggpubr)
library(openxlsx)
library(naniar)
library(dplyr)

# import data
counts_data <- read.csv("data/GSE183947_fpkm.csv")

# get metadata
res <- getGEO(GEO = "GSE183947", GSEMatrix = T)
res
class(res)

# metadata
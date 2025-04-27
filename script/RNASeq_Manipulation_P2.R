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
metadata <- pData(phenoData(res[[1]]))
metadata |>
  head()

# subset metadata
metadata_subsets <- metadata |>
  select(c(1, 10, 11,17))

# data processing/ cleaning
Metadata_modified <- metadata_subsets |>
  rename(Tissue = characteristics_ch1, Metastasis = characteristics_ch1.1) |>
  mutate(Tissue = gsub("tissue: ", "", Tissue)) |>
  mutate(Metastasis = gsub("metastasis: ", "", Metastasis))

# reshaping data
countsdata_long <- counts_data |>
  rename(Gene = X) |>
  pivot_longer(-Gene,
               names_to = "samples",
               values_to = "fpkm")

# joining data
Finaldata_counts <- countsdata_long |>
  left_join(Metadata_modified, by = c("samples" = "description"))

# export data
write.csv(Finaldata_counts, "data/GSE183947_counts.csv" , row.names = F)

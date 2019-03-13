library(readr)
library(dplyr)
library(purrr)
library(dcmsort)
library(here)
setwd(here::here())
xx = read_rds("data/CQ500CT285_CT-5mm.rds")
wide = subset_hdr(xx, keep_tags = c("(0018,1120)", relevant_tags()))
unique(wide$GantryDetectorTilt)


fnames = c(std = "data/CQ500CT23_CT-PRE-CONTRAST-5MM-STD.rds",
           bone = "data/CQ500CT23_CT-PRE-CONTRAST-BONE.rds",
           thin = "data/CQ500CT23_CT-PRE-CONTRAST-THIN.rds",
           post = "data/CQ500CT23_CT-5mm-POST-CONTRAST.rds")

df = map_df(fnames, read_rds,
            .id = "fname")
ddf = df %>%
  select(file, fname)
wide = subset_hdr(df, keep_tags = c("(0018,1120)", relevant_tags()))
wide = left_join(wide, ddf)

wide %>%
  select(fname, ConvolutionKernel, GantryDetectorTilt) %>%
  distinct()

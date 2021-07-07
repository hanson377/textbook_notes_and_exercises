library(tidyverse)

# getting started
# most of readrs functions are concerned with turning flat files into data frames
read_csv()
read_delim()
read_fwf()
read_log()

## compared to base r
## why not use read.csv() found within base r?
# 1. readr is typically much faster (~10x) than their base equivalent. long-running jobs have a progress bar as well
# 2. they produce tibbles and they dont convert character vectors to factors, use row names, or munge the column names
# 3. they are more reproducible. bae r functiosn inherit some behaviors from your OS and environment variables, so import code that works on your computer might not work on someone elses 

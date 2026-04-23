rm(list=ls());gc()

library(targets)
library(tarchetypes)
library(tveDataLoader)
library(tveDevTools)
library(tveTableTool)
library(renv)
library(dplyr)
library(stringr)

#renv::init()
#renv::restore()

# Run the R scripts in the R/ 
targets::tar_source()

# Run the R script containing all constant values used in pipeline
targets::tar_source(here::here('inst', 'scripts', 'objects.R'))

silly_test <- list(
  tar_target(s_test_5, test5()),
  tar_target(s_test_10, test10()),
  tar_target(s_test_20, s_test_10*2),
  tar_target(s_output, s_test_5-(sum(s_test_20)))
)
# List of target objects.
results <- list(
  tar_target(data, 
    tveDataLoader::load_sav(data_path = here::here("data",
    "5216196 - The Value Engineers, Target audience & growth strategy - Total File.sav"
  ),
  tibble_out = F
)),
  silly_test,
  targets::tar_target(data_vars,data$var_labels),
  targets::tar_target(var_scramble, 
    data_vars %>%
      mutate(vars_scramble = (as.numeric(str_remove_all(var_name,"\\D"))+sum(s_test_10))))
)

#renv::snapshot()

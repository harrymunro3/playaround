library(targets)
library(tarchetypes)
library(tveDataLoader)
library(tveDevTools)
library(tveTableTool)


# Run the R scripts in the R/ folder with your custom functions:
targets::tar_source()

# Run the R script containing all constant values used in pipeline
targets::tar_source(here::here('inst', 'scripts', 'objects.R'))


# End this file with a list of target objects.
results <- list(
  tar_target(data, 
    load_sav(data_path = here::here("data",
    "5216196 - The Value Engineers, Target audience & growth strategy - Total File.sav"
  ),
  tibble_out = F
)),
  tar_target(test_5, test5()),
  tar_target(test_10, test10()),
  tar_target(test_20, test_10*2),
  tar_target(output, test_5-(sum(test_20))) # Call your custom functions.
)



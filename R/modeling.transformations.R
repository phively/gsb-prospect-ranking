# Import the data
full.data <- read.csv("data/ABE Modeling.csv", stringsAsFactors=FALSE, strip.white=TRUE) %>%
  # Drop any null rows
  filter(!is.na(Entity.ID))
  
# Run clean.data.R
source("R/clean.data.R")

# Drop unneeded variables
mdat <- dat %>% select(
  one_of(scan("results/mdat.vars.txt", what="character"))
)
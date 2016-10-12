# Import the data
full.data <- read.csv("data/ABE Modeling.csv", stringsAsFactors=FALSE, strip.white=TRUE) %>%
  # Drop any null rows
  filter(!is.na(Entity.ID))
  
# Run clean.data.R
source("R/clean.data.R")

# Drop unneeded variables
mdat <- dat %>% 
  select(
    # Must be one of the variables identified by Boruta
    one_of(scan("results/mdat.vars.txt", what="character"))
  ) %>%
  # Numeric transformations
  mutate(
    Research.Non.Capacity = Research.Non.Capacity >= 1
  ) %>%
  # Factor transformations
  mutate(
    Giving.First.Trans.Amt = Giving.First.Trans.Amt %>% cut(breaks=c(0, 25, 50, 100, Inf), include.lowest=T, right=F)
  )

source("R/load_packages.R")

dm_raw <- read_csv("data/raw/dm_raw.csv")

dm <- dm_raw %>%
  mutate(
    STUDYID = "PK001",
    DOMAIN = "DM",
    USUBJID = paste(STUDYID, SUBJID, sep = "-")
  )

write_csv(
  dm,
  "data/sdtm/dm.csv"
)

print(dm)
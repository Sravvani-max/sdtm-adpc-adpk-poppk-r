
source("R/load_packages.R")

adsl <- read_csv("data/adam/adsl.csv")
adpc <- read_csv("data/adam/adpc.csv")

cmax <- adpc %>%
  group_by(STUDYID, USUBJID) %>%
  summarise(
    PARAMCD = "CMAX",
    PARAM = "Maximum Observed Concentration",
    AVAL = max(AVAL, na.rm = TRUE),
    AVALU = first(AVALU),
    .groups = "drop"
  )

tmax <- adpc %>%
  filter(AVAL == max(AVAL, na.rm = TRUE), .by = USUBJID) %>%
  transmute(
    STUDYID,
    USUBJID,
    PARAMCD = "TMAX",
    PARAM = "Time of Maximum Observed Concentration",
    AVAL = ATPTN,
    AVALU = "hours"
  )

adpk <- bind_rows(cmax, tmax) %>%
  left_join(
    adsl %>% select(USUBJID, TRT01P, TRT01A, SAFFL, PKFL, WEIGHTBL),
    by = "USUBJID"
  ) %>%
  select(
    STUDYID, USUBJID,
    TRT01P, TRT01A,
    PARAMCD, PARAM, AVAL, AVALU,
    SAFFL, PKFL, WEIGHTBL
  )

write_csv(adpk, "data/adam/adpk.csv")

print(adpk)
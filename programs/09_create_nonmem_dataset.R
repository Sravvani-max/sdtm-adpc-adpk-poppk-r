
source("R/load_packages.R")

adpc <- read_csv("data/adam/adpc.csv")
adsl <- read_csv("data/adam/adsl.csv")
ex   <- read_csv("data/sdtm/ex.csv")

dose <- ex %>%
  transmute(
    USUBJID,
    TIME = 0,
    TAD = 0,
    EVID = 1,
    MDV = 1,
    AMT = EXDOSE,
    DV = NA_real_,
    CMT = 1
  )

conc <- adpc %>%
  transmute(
    USUBJID,
    TIME = ATPTN,
    TAD = ATPTN,
    EVID = 0,
    MDV = if_else(is.na(AVAL), 1, 0),
    AMT = NA_real_,
    DV = AVAL,
    CMT = 2
  )

nonmem <- bind_rows(dose, conc) %>%
  left_join(
    adsl %>%
      select(USUBJID, SEX, RACE, WEIGHTBL, HEIGHTBL, CREATBL),
    by = "USUBJID"
  ) %>%
  mutate(
    ID = as.integer(factor(USUBJID))
  ) %>%
  arrange(ID, TIME, desc(EVID)) %>%
  select(
    ID, USUBJID, TIME, TAD,
    EVID, MDV, AMT, DV, CMT,
    SEX, RACE, WEIGHTBL, HEIGHTBL, CREATBL
  )

write_csv(nonmem, "data/adam/nonmem_pk.csv")

print(nonmem)
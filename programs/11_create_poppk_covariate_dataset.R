source("R/load_packages.R")

adsl <- read_csv("data/adam/adsl.csv")
nonmem <- read_csv("data/adam/nonmem_pk.csv")

poppk_cov <- nonmem %>%
  select(
    ID, USUBJID, TIME, TAD,
    EVID, MDV, AMT, DV, CMT,
    SEX, RACE, WEIGHTBL, HEIGHTBL, CREATBL
  ) %>%
  mutate(
    SEXN = case_when(
      SEX == "M" ~ 1,
      SEX == "F" ~ 0,
      TRUE ~ NA_real_
    ),
    WT = WEIGHTBL,
    HT = HEIGHTBL,
    SCR = CREATBL,
    STUDY = 1
  ) %>%
  select(
    ID, STUDY, USUBJID,
    TIME, TAD, EVID, MDV, AMT, DV, CMT,
    SEX, SEXN, RACE,
    WT, HT, SCR
  )

write_csv(poppk_cov, "data/adam/poppk_covariate_dataset.csv")

print(poppk_cov)
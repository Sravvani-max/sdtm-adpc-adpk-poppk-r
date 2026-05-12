
source("R/load_packages.R")

adsl <- read_csv("data/adam/adsl.csv")
pc <- read_csv("data/sdtm/pc.csv")

adpc <- pc %>%
  left_join(
    adsl %>% select(USUBJID, TRT01P, TRT01A, TRTSDTC, SAFFL, PKFL, WEIGHTBL),
    by = "USUBJID"
  ) %>%
  mutate(
    PARAMCD = PCTESTCD,
    PARAM = PCTEST,
    AVAL = PCSTRESN,
    AVALU = PCSTRESU,
    ADT = as.Date(substr(PCDTC, 1, 10)),
    ATPT = PCTPT,
    ATPTN = PCTPTNUM,
    BLQFL = PCBLQ,
    ANL01FL = if_else(!is.na(AVAL), "Y", NA_character_)
  ) %>%
  select(
    STUDYID, USUBJID,
    TRT01P, TRT01A, TRTSDTC,
    PARAMCD, PARAM,
    AVAL, AVALU,
    ADT, ATPT, ATPTN,
    BLQFL, ANL01FL,
    SAFFL, PKFL, WEIGHTBL
  )

write_csv(adpc, "data/adam/adpc.csv")

print(adpc)
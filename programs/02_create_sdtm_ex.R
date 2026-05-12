
source("R/load_packages.R")
source("R/derive_study_day.R")
source("R/derive_iso_datetime.R")

dm <- read_csv("data/sdtm/dm.csv")
ex_raw <- read_csv("data/raw/ex_raw.csv")

ex <- ex_raw %>%
  left_join(
    dm %>% select(SUBJID, STUDYID, USUBJID),
    by = "SUBJID"
  ) %>%
  mutate(
    DOMAIN = "EX",
    EXSEQ = row_number(),
    
    EXSTDTC = derive_iso_datetime(EXSTDAT, EXSTTIM),
    EXENDTC = derive_iso_datetime(EXENDAT, EXENTIM),
    
    TRTSDT = ymd(EXSTDAT),
    EXSTDT = ymd(EXSTDAT),
    EXENDT = ymd(EXENDAT),
    
    EXSTDY = derive_study_day(EXSTDT, TRTSDT),
    EXENDY = derive_study_day(EXENDT, TRTSDT),
    
    EXDOSFRM = "TABLET"
  ) %>%
  select(
    STUDYID, DOMAIN, USUBJID, EXSEQ,
    EXTRT, EXDOSE, EXDOSU, EXDOSFRM, EXROUTE,
    EXSTDTC, EXENDTC, EXSTDY, EXENDY,
    VISIT, VISITNUM
  )

write_csv(ex, "data/sdtm/ex.csv")

print(ex)
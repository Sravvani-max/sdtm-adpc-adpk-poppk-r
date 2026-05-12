
source("R/load_packages.R")
source("R/derive_study_day.R")
source("R/derive_iso_datetime.R")

dm <- read_csv("data/sdtm/dm.csv")
ex <- read_csv("data/sdtm/ex.csv")
lb_raw <- read_csv("data/raw/lb_raw.csv")

lb <- lb_raw %>%
  left_join(
    dm %>% select(SUBJID, STUDYID, USUBJID),
    by = "SUBJID"
  ) %>%
  left_join(
    ex %>% select(USUBJID, EXSTDTC),
    by = "USUBJID"
  ) %>%
  mutate(
    DOMAIN = "LB",
    LBSEQ = row_number(),
    LBDTC = derive_iso_datetime(LBDAT, LBTIM),
    LBDT = ymd(LBDAT),
    TRTSDT = ymd(substr(EXSTDTC, 1, 10)),
    LBDY = derive_study_day(LBDT, TRTSDT),
    LBSTRESN = as.numeric(LBORRES),
    LBSTRESC = as.character(LBORRES),
    LBSTRESU = LBORRESU
  ) %>%
  select(
    STUDYID, DOMAIN, USUBJID, LBSEQ,
    LBTESTCD, LBTEST,
    LBORRES, LBORRESU,
    LBSTRESC, LBSTRESN, LBSTRESU,
    LBDTC, LBDY,
    VISIT, VISITNUM
  )

write_csv(lb, "data/sdtm/lb.csv")

print(lb)
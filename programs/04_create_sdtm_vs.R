
source("R/load_packages.R")
source("R/derive_study_day.R")
source("R/derive_iso_datetime.R")

dm <- read_csv("data/sdtm/dm.csv")
ex <- read_csv("data/sdtm/ex.csv")
vs_raw <- read_csv("data/raw/vs_raw.csv")

vs <- vs_raw %>%
  left_join(
    dm %>% select(SUBJID, STUDYID, USUBJID),
    by = "SUBJID"
  ) %>%
  left_join(
    ex %>% select(USUBJID, EXSTDTC),
    by = "USUBJID"
  ) %>%
  mutate(
    DOMAIN = "VS",
    VSSEQ = row_number(),
    VSDTC = derive_iso_datetime(VSDAT, VSTIM),
    VSDT = ymd(VSDAT),
    TRTSDT = ymd(substr(EXSTDTC, 1, 10)),
    VSDY = derive_study_day(VSDT, TRTSDT),
    VSSTRESN = as.numeric(VSORRES),
    VSSTRESC = as.character(VSORRES),
    VSSTRESU = VSORRESU
  ) %>%
  select(
    STUDYID, DOMAIN, USUBJID, VSSEQ,
    VSTESTCD, VSTEST,
    VSORRES, VSORRESU,
    VSSTRESC, VSSTRESN, VSSTRESU,
    VSDTC, VSDY,
    VISIT, VISITNUM
  )

write_csv(vs, "data/sdtm/vs.csv")

print(vs)
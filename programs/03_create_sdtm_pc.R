
source("R/load_packages.R")
source("R/derive_study_day.R")
source("R/derive_iso_datetime.R")
source("R/derive_blq_flags.R")

dm <- read_csv("data/sdtm/dm.csv")
ex <- read_csv("data/sdtm/ex.csv")
pc_raw <- read_csv("data/raw/pc_raw.csv")

ex_ref <- ex %>%
  select(SUBJID = USUBJID, EXSTDTC)

pc <- pc_raw %>%
  left_join(
    dm %>% select(SUBJID, STUDYID, USUBJID),
    by = "SUBJID"
  ) %>%
  left_join(
    ex %>% select(USUBJID, EXSTDTC),
    by = "USUBJID"
  ) %>%
  mutate(
    DOMAIN = "PC",
    PCSEQ = row_number(),
    PCDTC = derive_iso_datetime(PCDAT, PCTIM),
    PCDT = ymd(PCDAT),
    TRTSDT = ymd(substr(EXSTDTC, 1, 10)),
    PCDY = derive_study_day(PCDT, TRTSDT),
    PCSTRESN = as.numeric(PCORRES),
    PCSTRESC = as.character(PCORRES),
    PCSTRESU = PCORRESU,
    PCBLQ = derive_blq_flag(PCSTRESN, LLOQ),
    PCTPTREF = "Start of Dose",
    PCRFTDTC = EXSTDTC,
    PCCAT = "PK CONCENTRATION"
  ) %>%
  select(
    STUDYID, DOMAIN, USUBJID, PCSEQ,
    PCTESTCD, PCTEST, PCCAT, PCSPEC,
    PCORRES, PCORRESU, PCSTRESC, PCSTRESN, PCSTRESU,
    PCBLQ, LLOQ,
    PCDTC, PCDY,
    PCTPT, PCTPTNUM, PCTPTREF, PCRFTDTC,
    VISIT, VISITNUM
  )

write_csv(pc, "data/sdtm/pc.csv")

print(pc)
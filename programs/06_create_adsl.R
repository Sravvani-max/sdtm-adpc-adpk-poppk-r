
source("R/load_packages.R")

dm <- read_csv("data/sdtm/dm.csv")
vs <- read_csv("data/sdtm/vs.csv")
lb <- read_csv("data/sdtm/lb.csv")
ex <- read_csv("data/sdtm/ex.csv")

weight <- vs %>%
  filter(VSTESTCD == "WEIGHT") %>%
  select(USUBJID, WEIGHTBL = VSSTRESN)

height <- vs %>%
  filter(VSTESTCD == "HEIGHT") %>%
  select(USUBJID, HEIGHTBL = VSSTRESN)

creat <- lb %>%
  filter(LBTESTCD == "CREAT") %>%
  select(USUBJID, CREATBL = LBSTRESN)

trt <- ex %>%
  select(USUBJID, TRT01P = EXTRT, TRTSDTC = EXSTDTC) %>%
  distinct()

adsl <- dm %>%
  left_join(trt, by = "USUBJID") %>%
  left_join(weight, by = "USUBJID") %>%
  left_join(height, by = "USUBJID") %>%
  left_join(creat, by = "USUBJID") %>%
  mutate(
    TRT01A = TRT01P,
    SAFFL = "Y",
    PKFL = "Y"
  ) %>%
  select(
    STUDYID, USUBJID, SUBJID,
    SEX, RACE, ARM,
    TRT01P, TRT01A, TRTSDTC,
    SAFFL, PKFL,
    WEIGHTBL, HEIGHTBL, CREATBL
  )

write_csv(adsl, "data/adam/adsl.csv")

print(adsl)
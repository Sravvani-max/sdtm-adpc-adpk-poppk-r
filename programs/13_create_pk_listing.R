source("R/load_packages.R")

adpc <- read_csv("data/adam/adpc.csv")

pk_listing <- adpc %>%
  arrange(USUBJID, ATPTN) %>%
  select(
    USUBJID,
    TRT01A,
    PARAM,
    ATPT,
    ATPTN,
    AVAL,
    AVALU,
    BLQFL,
    ANL01FL
  ) %>%
  mutate(
    AVAL = round(AVAL, 2)
  )

write_csv(
  pk_listing,
  "output/listings/pk_concentration_listing.csv"
)

print(pk_listing)
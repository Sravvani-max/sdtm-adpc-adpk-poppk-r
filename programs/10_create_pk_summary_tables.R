source("R/load_packages.R")

adpc <- read_csv("data/adam/adpc.csv")
adpk <- read_csv("data/adam/adpk.csv")
nonmem <- read_csv("data/adam/nonmem_pk.csv")

# Concentration summary by timepoint
conc_summary <- adpc %>%
  group_by(TRT01A, ATPT, ATPTN) %>%
  summarise(
    N = sum(!is.na(AVAL)),
    MEAN = round(mean(AVAL, na.rm = TRUE), 2),
    SD = round(sd(AVAL, na.rm = TRUE), 2),
    MEDIAN = round(median(AVAL, na.rm = TRUE), 2),
    MIN = round(min(AVAL, na.rm = TRUE), 2),
    MAX = round(max(AVAL, na.rm = TRUE), 2),
    .groups = "drop"
  ) %>%
  arrange(TRT01A, ATPTN)

# PK parameter summary
pk_param_summary <- adpk %>%
  group_by(TRT01A, PARAMCD, PARAM, AVALU) %>%
  summarise(
    N = sum(!is.na(AVAL)),
    MEAN = round(mean(AVAL, na.rm = TRUE), 2),
    SD = round(sd(AVAL, na.rm = TRUE), 2),
    MEDIAN = round(median(AVAL, na.rm = TRUE), 2),
    MIN = round(min(AVAL, na.rm = TRUE), 2),
    MAX = round(max(AVAL, na.rm = TRUE), 2),
    .groups = "drop"
  )

# NONMEM record count summary
nonmem_summary <- nonmem %>%
  group_by(EVID, MDV, CMT) %>%
  summarise(
    N_RECORDS = n(),
    .groups = "drop"
  )

write_csv(conc_summary, "output/tables/concentration_summary.csv")
write_csv(pk_param_summary, "output/tables/pk_parameter_summary.csv")
write_csv(nonmem_summary, "output/tables/nonmem_record_summary.csv")

print(conc_summary)
print(pk_param_summary)
print(nonmem_summary)
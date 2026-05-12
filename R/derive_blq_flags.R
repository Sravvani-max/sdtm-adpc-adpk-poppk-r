

derive_blq_flag <- function(conc, lloq) {
  dplyr::case_when(
    is.na(conc) ~ NA_character_,
    conc < lloq ~ "Y",
    TRUE ~ "N"
  )
}
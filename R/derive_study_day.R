
derive_study_day <- function(date, ref_date) {
  
  dplyr::case_when(
    is.na(date) | is.na(ref_date) ~ NA_integer_,
    date >= ref_date ~ as.integer(date - ref_date +1),
    TRUE ~ as.integer(date - ref_date)
  )
}
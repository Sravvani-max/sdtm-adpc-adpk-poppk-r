
derive_iso_datetime <- function (date, time = NULL) {
  
  if(is.null(time)) {
    return(as.character(date))
  }
  
  ifelse(
    is.na(time),
    as.character(date),
    paste0(as.character(date), "T", as.character(time))
  )
}
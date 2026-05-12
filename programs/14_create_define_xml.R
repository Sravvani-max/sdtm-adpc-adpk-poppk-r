source("R/load_packages.R")

define_meta <- read_csv("metadata/define_metadata.csv")

xml_lines <- c(
  '<?xml version="1.0" encoding="UTF-8"?>',
  '<Define>',
  '  <StudyName>Clinical PK SDTM ADaM R Portfolio</StudyName>',
  '  <Description>Simplified define.xml-style metadata for portfolio demonstration</Description>',
  '  <Datasets>'
)

datasets <- unique(define_meta$DATASET)

for (ds in datasets) {
  xml_lines <- c(
    xml_lines,
    paste0('    <Dataset Name="', ds, '">')
  )
  
  ds_meta <- define_meta %>% filter(DATASET == ds)
  
  for (i in seq_len(nrow(ds_meta))) {
    xml_lines <- c(
      xml_lines,
      paste0(
        '      <Variable Name="', ds_meta$VARIABLE[i],
        '" Label="', ds_meta$LABEL[i],
        '" Type="', ds_meta$TYPE[i],
        '" Origin="', ds_meta$ORIGIN[i],
        '" Source="', ds_meta$SOURCE[i],
        '" Derivation="', ds_meta$DERIVATION[i],
        '" />'
      )
    )
  }
  
  xml_lines <- c(xml_lines, paste0('    </Dataset>'))
}

xml_lines <- c(
  xml_lines,
  '  </Datasets>',
  '</Define>'
)

writeLines(xml_lines, "metadata/define.xml")

cat("define.xml created successfully\n")
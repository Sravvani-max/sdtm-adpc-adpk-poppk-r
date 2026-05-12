# =========================
# Master Driver Program
# Clinical PK Workflow
# =========================
rm(list = ls())
gc()

cat("Starting SDTM and ADaM workflow...\n")

# SDTM
source("programs/01_create_sdtm_dm.R")
source("programs/02_create_sdtm_ex.R")
source("programs/03_create_sdtm_pc.R")
source("programs/04_create_sdtm_vs.R")
source("programs/05_create_sdtm_lb.R")

cat("SDTM datasets completed...\n")

# ADaM
source("programs/06_create_adsl.R")
source("programs/07_create_adpc.R")
source("programs/08_create_adpk.R")

cat("ADaM datasets completed...\n")

# NONMEM / PopPK
source("programs/09_create_nonmem_dataset.R")
source("programs/11_create_poppk_covariate_dataset.R")

cat("NONMEM and PopPK datasets completed...\n")

# Outputs
source("programs/10_create_pk_summary_tables.R")
source("programs/12_create_spaghetti_plot.R")
source("programs/13_create_pk_listing.R")

cat("Tables, listings, and plots completed...\n")

# Metadata
source("programs/14_create_define_xml.R")

cat("define.xml generation completed...\n")

# Quarto Report
quarto::quarto_render("reports/pk_tlf_report.qmd")

cat("Quarto TLF report generated...\n")

cat("Workflow completed successfully!\n")
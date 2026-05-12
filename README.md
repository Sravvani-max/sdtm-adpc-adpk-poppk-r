# Clinical PK SDTM ADaM R Workflow

## Overview

End-to-end R-based clinical PK programming workflow demonstrating:

- SDTM dataset generation
- ADaM dataset creation
- NONMEM / PopPK dataset preparation
- Automated TLF reporting
- Shiny-based review application
- Metadata-driven programming
- Simplified define.xml generation

## SDTM Domains

- DM
- EX
- PC
- VS
- LB

## ADaM Datasets

- ADSL
- ADPC
- ADPK

## PopPK / NONMEM

- NONMEM-ready dataset
- PopPK covariate dataset

## Outputs

- Summary tables
- PK concentration listing
- Spaghetti plot
- Automated Quarto TLF report

## Applications

- Interactive Shiny review app

## Reusable Functions

- derive_study_day()
- derive_iso_datetime()
- derive_blq_flag()

## Reporting

Automated TLF generation implemented using Quarto.

## Metadata

Includes simplified define.xml-style metadata for SDTM and ADaM traceability.

## Note

This project is intended for portfolio and educational demonstration purposes and does not represent a validated regulatory submission package.
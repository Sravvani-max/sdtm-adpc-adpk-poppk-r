Project Overview: I developed an end-to-end clinical PK programming workflow in R to demonstrate SDTM, ADaM, PopPK/NONMEM, reporting automation, and interactive review capabilities. The project was designed to mimic a production-style clinical pharmacology workflow using modular scripts, reusable functions, metadata-driven programming, and GitHub version control.
Why I Built This Project: I wanted to strengthen my R-based PK/PD programming skills and demonstrate how R can be used for SDTM generation, ADaM dataset creation, PK analysis workflows, automated reporting, and interactive data review.
3. SDTM Domains Created
DM
Purpose:
subject-level demographics
unique subject identifiers
sex and race
DM serves as the foundational subject-level domain used across SDTM and ADaM.
EX
Purpose:
dose amount
route
treatment timing
EX is critical for PK workflows because it provides dosing information needed for elapsed time calculations, exposure derivations, ADPC, ADPK, and NONMEM datasets.
PC
Purpose:
concentration-time samples
nominal and actual PK timepoints
BLQ handling
PC is the core PK SDTM domain containing concentration measurements collected over time. It directly feeds ADPC and later supports ADPK and NONMEM workflows.
VS
Purpose:
weight
height
BMI-related covariates
VS provides important PopPK covariates such as body weight and height.
LB
Purpose:
renal and hepatic covariates
LB supports PK and PopPK analyses by providing laboratory covariates such as creatinine, AST, and ALT.

Reusable Functions

derive_study_day()
Purpose:
derive relative study day
I created reusable derivation functions to standardize common SDTM transformations and improve reproducibility.

derive_iso_datetime()
Purpose:
ISO8601 datetime creation
This function standardizes SDTM datetime formatting across domains.

derive_blq_flag()
Purpose:
BLQ handling
The BLQ function identifies values below the lower limit of quantification and supports downstream PK analyses.

ADaM Datasets
ADSL
Purpose:
subject-level analysis dataset
ADSL consolidates treatment, demographic, and baseline covariate information used throughout analysis datasets.
ADPC
Purpose:
concentration-time analysis dataset
ADPC is the primary PK analysis dataset containing analysis-ready concentration data, timepoints, BLQ flags, and treatment variables.
ADPK
Purpose:
derived PK parameters
ADPK contains derived PK parameters such as Cmax and Tmax generated from ADPC.
NONMEM / PopPK Dataset
I created a NONMEM-ready dataset combining dose records, concentration records, and subject-level covariates. The dataset included variables such as TIME, DV, AMT, EVID, MDV, CMT, and baseline covariates used in PopPK workflows.”
My focus was preparing clean analysis-ready datasets to support pharmacometricians and modelers.
Summary Tables and Listings
I created automated PK summary tables and concentration listings to support exploratory review and reporting workflows.
8. Spaghetti Plot
I created a spaghetti plot to visualize individual concentration-time profiles and assess inter-subject variability, absorption trends, and elimination behavior.
Possible trends:
high variability
delayed absorption
exposure differences
outliers

Quarto Automated Reporting
I used Quarto to automate TLF-style report generation. The workflow automatically generated tables, listings, and figures from the ADaM datasets in a reproducible format.
The same workflow could also be implemented using R Markdown depending on sponsor standards.

Shiny Application
I built a Shiny review application allowing interactive review of ADSL, ADPC, ADPK, and NONMEM datasets. This improves reviewer efficiency and supports exploratory PK review workflows.

Metadata and define.xml
I added SDTM, ADaM, and output specification files along with a simplified define.xml-style metadata file to demonstrate traceability and metadata-driven programming.
The define.xml was created for portfolio demonstration and is not intended to represent a fully validated regulatory define.xml package.

Workflow Automation
I created a master driver program that orchestrates the complete workflow from SDTM generation through ADaM, NONMEM datasets, outputs, metadata generation, and automated reporting.
Validation / QC
I validated intermediate outputs throughout the workflow and verified dataset structures, joins, and derived variables during development.
compareDF
anti_join checks
duplicate checks
missingness review
GitHub and Version Control
I used GitHub for version control, workflow organization, and portfolio demonstration of reusable clinical PK programming workflows.
This project helped me strengthen my R-based PK/PD programming skills across SDTM, ADaM, NONMEM-ready datasets, automated reporting, and interactive review workflows. It also gave me hands-on experience designing modular, reusable, and reproducible clinical programming workflows in R.

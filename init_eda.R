# Read in the data
auto_raw <- read.csv("~/Projects/4339_project/autoimmune.csv")

# Inspect structure and basic summaries
str(auto_raw)
summary(auto_raw)

# Select variables we plan to use
keep_vars <- c(
  "Age",
  "Gender",
  "Diagnosis",
  "Sickness_Duration_Months",
  "ESR",
  "CRP",
  "ANA",
  "C3",
  "C4",
  "RBC_Count",
  "Hemoglobin",
  "Hematocrit",
  "MCV",
  "MCH",
  "MCHC",
  "RDW",
  "WBC_Count",
  "PLT_Count",
  "Neutrophils",
  "Lymphocytes",
  "Monocytes",
  "Eosinophils",
  "Basophils"
)
auto_sel <- auto_raw[, keep_vars]

# Inspect new structure + basic summaries
str(auto_sel)
summary(auto_sel)

# Load dplyr FIRST before using %>%
library(dplyr)

# Convert categorical cols to factors
auto_sel$Gender <- as.factor(auto_sel$Gender)
auto_sel$Diagnosis <- as.factor(auto_sel$Diagnosis)
str(auto_sel)

# Create grouped diagnosis variable directly on auto_sel
auto_sel <- auto_sel %>%
  mutate(Diagnosis_Group = case_when(
    
    # 1. NORMAL/CONTROL GROUP
    Diagnosis == "Normal" ~ "Normal",
    
    # 2. RHEUMATOLOGICAL DISORDERS (joint/connective tissue)
    Diagnosis %in% c("Rheumatoid arthritis", 
                     "Systemic Lupus Erythematosus",
                     "Sjögren syndrome",
                     "Scleroderma (systemic sclerosis)",
                     "Polymyalgia rheumatica",
                     "Polymyositis",
                     "Dermatomyositis",
                     "Myositis",
                     "Inclusion body myositis",
                     "Fibromyalgia",
                     "Undifferentiated connective tissue disease (UCTD)",
                     "Discoid lupus erythematosus",
                     "Lupus nephritis",
                     "Lupus vasculitis",
                     "Rheumatoid lung disease",
                     "Rheumatoid vasculitis") ~ "Rheumatological",
    
    # 3. NEUROLOGICAL DISORDERS
    Diagnosis %in% c("Multiple sclerosis",
                     "Myasthenia gravis",
                     "Guillain-Barré syndrome",
                     "Neuromyelitis optica",
                     "Neuromyelitis optica (Devic's disease)/NMOSD",
                     "Chronic inflammatory demyelinating polyneuropathy",
                     "Lambert–Eaton myasthenic syndrome",
                     "Autoimmune encephalitis",
                     "Anti-NMDA receptor encephalitis",
                     "Hashimoto's encephalopathy",
                     "Acute disseminated encephalomyelitis",
                     "Balo concentric sclerosis",
                     "Idiopathic inflammatory demyelinating diseases",
                     "Bickerstaff's encephalitis",
                     "Optic neuritis",
                     "Transverse myelitis",
                     "Acute motor axonal neuropathy",
                     "Stiff-person syndrome",
                     "Neuromyotonia",
                     "Paraneoplastic cerebellar degeneration",
                     "Opsoclonus myoclonus syndrome",
                     "Sydenham's chorea",
                     "Restless legs syndrome") ~ "Neurological",
    
    # 4. ENDOCRINE/METABOLIC DISORDERS
    Diagnosis %in% c("Graves' disease",
                     "Hashimoto's thyroiditis",
                     "Ord's thyroiditis",
                     "Graves' ophthalmopathy",
                     "Diabetes mellitus type 1",
                     "Addison's disease",
                     "Autoimmune polyendocrine syndrome type 1 (APS1)",
                     "Autoimmune polyendocrine syndrome type 2 (APS2)",
                     "Autoimmune polyendocrine syndrome type 3 (APS3)",
                     "Autoimmune oophoritis",
                     "Autoimmune orchitis",
                     "Premature ovarian failure",
                     "Autoimmune progesterone dermatitis") ~ "Endocrine",
    
    # 5. GASTROINTESTINAL DISORDERS
    Diagnosis %in% c("Crohn's disease",
                     "Ulcerative colitis",
                     "Celiac disease",
                     "Autoimmune hepatitis",
                     "Primary sclerosing cholangitis",
                     "Autoimmune pancreatitis",
                     "Autoimmune enteropathy",
                     "Pernicious anemia") ~ "Gastrointestinal",
    
    # 6. DERMATOLOGICAL DISORDERS (skin)
    Diagnosis %in% c("Psoriasis",
                     "Vitiligo",
                     "Alopecia areata",
                     "Pemphigus vulgaris",
                     "Bullous pemphigoid",
                     "Cicatricial pemphigoid",
                     "Gestational pemphigoid",
                     "Dermatitis herpetiformis",
                     "Epidermolysis bullosa acquisita",
                     "Linear IgA disease",
                     "Lichen planus",
                     "Lichen sclerosus",
                     "Morphea",
                     "Hidradenitis suppurativa",
                     "Erythema nodosum",
                     "Autoimmune urticaria",
                     "Urticarial vasculitis") ~ "Dermatological",
    
    # 7. VASCULITIS & VASCULAR DISORDERS
    Diagnosis %in% c("Behçet's disease",
                     "Giant cell arteritis",
                     "Takayasu's arteritis",
                     "Granulomatosis with polyangiitis (GPA)",
                     "Eosinophilic granulomatosis with polyangiitis (EGPA)",
                     "Microscopic polyangiitis (MPA)",
                     "Polyarteritis nodosa (PAN)",
                     "IgA vasculitis (IgAV)",
                     "Leukocytoclastic vasculitis",
                     "Vasculitis",
                     "Kawasaki disease",
                     "Antiphospholipid syndrome",
                     "Rheumatic heart disease") ~ "Vasculitis",
    
    # 8. HEMATOLOGICAL & OTHER ORGAN-SPECIFIC DISORDERS
    Diagnosis %in% c("Autoimmune hemolytic anemia",
                     "Immune thrombocytopenia",
                     "Thrombotic thrombocytopenic purpura",
                     "Paroxysmal nocturnal hemoglobinuria",
                     "Goodpasture syndrome",
                     "IgA nephropathy",
                     "Membranous nephropathy",
                     "Interstitial nephritis",
                     "Idiopathic pulmonary fibrosis",
                     "Interstitial lung disease",
                     "Pulmonary alveolar proteinosis",
                     "Sarcoidosis",
                     "Autoimmune uveitis",
                     "Intermediate uveitis",
                     "Autoimmune retinopathy",
                     "Sympathetic ophthalmia",
                     "Mooren's ulcer",
                     "Scleritis",
                     "Ligneous conjunctivitis",
                     "Cogan syndrome",
                     "Susac's syndrome",
                     "Tolosa–Hunt syndrome",
                     "Interstitial cystitis",
                     "Endometriosis",
                     "Autoimmune angioedema") ~ "Hematological_OrganSpecific",
    
    # Catch any that might have been missed
    TRUE ~ "Other"
  ))

# Convert Diagnosis_Group to factor
auto_sel$Diagnosis_Group <- as.factor(auto_sel$Diagnosis_Group)

# Look at sample sizes
table(auto_sel$Diagnosis_Group)

# Check for missing values in key variables
colSums(is.na(auto_sel))

# Remove rows with missing values (optional - uncomment if needed)
# auto_clean <- na.omit(auto_sel)
# OR remove only rows with missing diagnosis group:
# auto_clean <- auto_sel[!is.na(auto_sel$Diagnosis_Group), ]

# Multivariate Analysis of Autoimmune Disease Data


This project analyzes a dataset of over 12,000 patients to investigate the relationships between autoimmune diseases, demographic factors, and clinical blood markers. The primary goal is to understand the structure of hematological data and identify multivariate differences between disease groups and genders.

## Dataset
* **Source:** Comprehensive Autoimmune Disorder Dataset (Kaggle).
* **Size:** ~12,500 observations and 79 variables.
* **Structure:** The data includes demographic variables (Age, Gender), clinical diagnoses, and laboratory measurements (CBC, ESR, CRP).
* **Preprocessing:** The original 116 diagnoses were grouped into **8 clinical categories** (e.g., Normal, Rheumatological, Neurological, Vasculitis) to improve statistical stability.

## Research Questions & Methods

### 1. Dimensionality Reduction
* **Question:** Can a small number of principal components summarize the variation in Complete Blood Count (CBC) variables? 
* **Method:** Principal Component Analysis (PCA).
* **Finding:** Variation is spread relatively evenly across components; ~10 components are needed to explain 80% of the variance, indicating high dimensionality in blood profiles.

### 2. Modeling Inflammation (ESR)
* **Question:** Which demographic and laboratory variables are most strongly related to ESR?
* **Method:** Multiple Linear Regression.
* **Finding:** Sickness Duration and CRP are significant positive predictors, while RBC Count and Hemoglobin are negative predictors. Demographic factors (Age/Gender) were not significant in this model.

### 3. Disease Group Comparison
* **Question:** Are there multivariate differences in clinical measurements across different autoimmune diagnoses? 
* **Method:** MANOVA (Wilks' Lambda) with Bonferroni-corrected univariate ANOVAs.
* **Finding:** Significant differences exist (p < 2.2e-16). Post-hoc analysis revealed that **RBC Count, Hemoglobin, and Hematocrit** are the primary differentiators between healthy and sick groups.

### 4. Gender Differences
* **Question:** Do males and females differ in their multivariate clinical profiles? 
* **Method:** Inference for Multivariate Means (Two-group MANOVA / Hotelling’s $T^2$)
* **Finding:** Significant multivariate differences were found between male and female blood profiles, necessitating sex-specific analysis in clinical settings.

## Technologies Used
* **Language:** R
* **Key Libraries:** `tidyverse`, `ggplot2`, `MVN`, `biotools`, `gridExtra`.

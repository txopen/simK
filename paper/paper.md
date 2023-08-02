---
title: 'simK: Synthetic Data on Kidney Transplantation'
tags:
- R
- transplantation
- simulations
- synthetic data
date: "02 August 2023"
output:
  pdf_document: default
  html_document:
    df_print: paged
authors:
- name: Bruno A Lima
  orcid: 0000-0001-9090-4457
  affiliation: 1
bibliography: paper.bib
link-citations: yes
affiliations:
- name: Transplant Open Registry, Oficina de Bioestatistica, Portugal
  index: 1
---

# Summary

Synthetic data can be used to validate mathematical models and to train machine learning algorithms. Furthermore, distinct subject-specific investigations would necessitate different data. Privacy issues, data sensitivity, copyrights, and legal constraints, on the other hand, are frequently substantial impediments to accessing the necessary data. 
In the case of kidney transplantation, different countries have their own kidney allocation systems (KAS) in place, to balance the concepts of fairness and utility in the distribution of such scarce resource [@Lima:2020]. Access to health data is becoming increasingly restricted, however synthetic data can always be used to evaluate alternative KAS and its modifications.

The goal of this package is to allow generate synthetic data that can be used on the evaluation and assessment of KAS in transplantation.

# Statement of need

`simK` is an R [@R] package that assembles functions that allow to generate synthetic data sets with demographic, clinical and immunologic characteristics of wait listed candidates for kidney transplantation and a pool of deceased donors. Data generated with `simK` are particularly useful with the package `histoc` [@Lima:2022a] and the application Kidney Allocation Rules Simulator (KARS) [@Lima:2022b]. With this two packages it is possible to simulate allocation rules implemented in Portugal [@PT], in countries within Eurotransplant [@ET], in the United Kingdom [@UK], and a system suggested by [@Lima:2013b].

Access to health data is generally limited by issues of confidentiality of individuals' information. Researchers' access to this type of data is usually dependent on consents for use, protocol approval, ethical review approval, bureaucracies for data requests, and financial costs [@Gonzales:2023]. Nevertheless, sometimes, when it is not possible to have access to real data for proprietary or even logistical reasons, there is the alternative of using synthetic data. This type of data can be created, used, shared and discarded without major associated costs and is useful for researchers, innovators and data entrepreneurs alike, however different their purposes may be. Moreover, this data can be made available and used, publicly and free of charge, by industry, innovators, researchers, education and without legal, privacy, security, financial, and intellectual property limitations [@Walonoski:2018].

The US Census Bureau defines synthetic data as:: “microdata records created by statistically modeling original data and then using those models to generate new data values that reproduce the original data’s statistical properties” [@Philpott:2017]. Likewise, synthetic data can thus be a substitute for real records, useful for secondary uses that require realistic but not necessarily real data [@Chen:2019].

Synthetic data generation is increasingly used in research to test and evaluate the applicability of new statistical methods or new algorithms. In such cases, data synthesis seeks to provide test data that can reflect as accurately as possible the complexity of the real-world data where an algorithm under evaluation is to be applied. Moreover, synthetic data sets can also complement real data allowing researchers to increase their sample size or add variables that are not present in an original data set, enabling new levels of validation and comparison to test and develop new machine learning methods and algorithms [@Gonzales:2023].

Several R [@R] packages are already available to synthesize different types of data [@ctv:2021]. Although, none of these can be used in the specific case of KAS simulation without having as input your own data.

The `simK` outcomes are easily verifiable, modifiable, and redefined, which is a clear benefit as a facilitator of transparency and a desired continuous improvement.

## Synthetic data sets

### Donors' pool

A data frame with information for a pool of simulated donors can be generated with the function `donors_df()`.

For a given number of `n` rows, a data frame is generated with columns:

 + _ID_ unique identifier with the prefix ‘D’;
 + _bg_ with the blood group generated from the parameter probs a vector with the probabilities for groups A, AB, B and O, respectively;
 + _A1_, _A2_, _B1_, _B2_, _DR1_, _DR2_ HLA typing obtained according to `origin` option (with `replace = TRUE` we can generate a data frame without limitations on the number of rows);
 + age generated from a Normal distribution with `mean` and sd given by the user, values truncated by `lower`  and `upper` boundaries;
 + _DRI_ when option `uk = TRUE`, Donor Risk Index is copmputed as described by `transplantr` [@transplantr]

HLA population origin has currently as valid options ‘PT’ for Portuguese [@Lima:2013a], and populations available from US National Marrow Donor Program [@nmdp:2023]:

 + ‘API’ - Asian / Pacific Islander
 + ‘AFA’ - African American / Black
 + ‘CAU’ - White / Caucasian
 + ‘HIS’ - Hispanic

Defining `seed.number` allows for reproducibility.

### Kidney transplant candidates

A simulated waiting list for kidney transplant candidates, can be generated with `candidates_df()`.

For a given number of `n` rows, a data frame is generated with columns: 

  + *ID* unique identifier with the prefix 'K'; 
  + *bg* with the blood group generated from the parameter `probs.abo` a vector with the probabilities for groups A, AB, B and O, respectively (here by default, we assumed group O patients are more frequent); 
  + *A1*, *A2*, *B1*, *B2*, *DR1*, *DR2* HLA typing obtained according to `origin` option (with `replace = TRUE` we can generate a data frame without limitations on the number of rows);
  + *age* generated from a Normal distribution with `mean` and `sd` given by the user, values truncated by `lower` and `upper` boundaries;
  + *dialysis* time on dialysis **in months**, values computed according to patients' blood group and hypersensitation status ($cPRA > 85%$): for patients with blood group O **and** Hypersinsitized time on dialysis obtained from $N(85, 20)$; for those patients blood O **or** Hypersinsitized $N(70,20)$; remaining patients have time on dialysis obtained from $N(35,20)$;
  + *cPRA* patients are classified in groups with probabilities given by `probs.cpra` for 0%, 1%-50%, 51%-85% and 86%-100%, respectively. Within the groups > 0%, cPRA are computed as random values from distributions $P(\lambda = 30)$, $P(\lambda = 70)$ and $P(\lambda = 90)$;
  + *Tier* patients are classified in two Tiers as described on POL186/11 – Kidney Transplantation: Deceased Donor Organ Allocation from UK transplant [@UK]. In Tier A are patients with $MS = 10$ or $cPRA = 100%$ or $time on dialysis > 7 years$, all remaing patients are classified as Tier B;
  + *MS* matchabilily score are the deciles obtained from the number of donors on dataset `D10K` that are a match to each transplant candidate. This score takes into account a patient’s blood type, HLA type and cPRA value. A patient with a MS = 1 is defined as easy to match and a MS = 10 as difficult to match [@UK].
  + *RRI* when option `uk = TRUE`, Recipient Risk Index is copmputed as described by `transplantr` [@transplantr]. To compute *RRI*, variables *age*, time on *dialysis* (in days) and the probability of being *diabetic* (obtained from `prob.dm`) are used. Also, we assumed all patients were on dialysis at time of listing.
  + *urgent* a diccotomic variavel that assumes 1 for clinical urgent patients. It's  generated from `prob.urgent`.
  
HLA population `origin` can be defined from options: 'PT','API','AFA','CAU' and 'HIS', as reported for `donors_df()` data frame. 
  
Defining `seed.number` allows for reproducibility.


## Input data

The package presented here (`simK`), returns only fully synthetic data because it only requires common summary statistics (that can be found for different populations) as inputs to generate the new microdata.

## Bug reports and contributions

Any bug reporting, feature requests, or other feedback will be welcomed by [submitting an issue](https://github.com/txopen/simK/issues) in our repository. When reporting a bug, please ensure that a reproducible example of your code is included so that we may respond to your issue promptly.

# Funding

This project received the “Antonio Morais Sarmento” research grant from the Portuguese Society of Transplantation. This funding had no role in: study design; software development; the writing of the report; neither in the decision to submit the article for publication.

# References

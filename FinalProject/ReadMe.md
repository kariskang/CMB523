## Comparing the frequency of short DNA sequences among coastal grass populations: A coding exercise for Basic Programing for Life Sciences (CMB 523)

### Introduction
Sea level rise (SLR) in the U.S. northeast is ~3-4 times the global average, increasing at a significantly higher rate than the Pacific or Gulf coasts (Boon, 2012; Sallenger et al., 2012) and compounding the ongoing loss of saltmarsh habitat caused by anthropogenic disturbance. New England has lost 37% of its original saltmarshes, with Rhode Island losing the greatest portion of marsh area among New England states at 53% (Bromberg & Bertness, 2005). Loss of saltmarsh habitat impacts not only ecosystem services such as carbon sequestration (Macreadie et al., 2021; Mcleod et al., 2011), hurricane mitigation (Narayan et al., 2017), wildlife habitat (zu Ermgassen et al., 2021), and nutrient cycling (de Groot et al., 2012), but also jeopardizes genetic diversity in the coastal grasses that serve as ecosystem engineers for these systems. When genetic diversity is lost through reduction of population size (Zambrano et al., 2019), evolutionary potential for adaptation is diminished and can reduce a population’s ability to respond to rapid environmental change (Kramer & Haven, 2009). Thus understanding the level of genetic diversity both within and among populations is essential for coastal management when considering which populations to prioritize for conservation, which populations seed should be sourced when attempting to revegete degraded marshes, and planning for long-term population resilience in the face of climate change. 

*Spartina alterniflora*, also know as *Sporobolus alterniflora*, is a dominant low-marsh plant found in the most heavily indunated seaward edge of the marsh. Previous studies have found significant levels of within-population genetic diversity (Hughes & Lotteros) and genetic differentiation among populations (Blum). A recent study by [Zerebecki et al. 2021](https://www.journals.uchicago.edu/doi/full/10.1086/716512?casa_token=81ZmvLXFw6QAAAAA%3Abp0plFHqk9asQU_zYnUOOeXsb5AG42Zo3xZRHV_xrFY7GyrK--ZhA_AsE_KaiJzHTbcVhEhF) used SNP analysis to compare *Spartina* populations from eleven marshes in Massachusetts, New Hampshire, Rhode Island, North Carolina, South Carolina, and Florida. While the study itself looked at differentation between two distinct *Spartina* forms, tall- and short-form, as seen across populations, for the purposes of this project I am looking at differentiation across populations in order familiarize myself with R packages used in SNP analysis and to apply coding skills learned in this class to datasets relevant to my area of research. 

### Data 
All *Spartina* RADseq data was downloaded from the [study's page on GenBank](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA733197) as FASTQ files. Five samples were chosen from a single site in New Hampshire and five from a single site in North Carolina, as cross referenced with the biosample data available; because tall- or short-form identifying data could not be found through the database, I opted to go with two sites (NH1 and NC1) where the form had been classified as "unidentified", rather than risk comparing sites from which two distinct types of *Spartina* had been collected. FASTQ files were imported and filtered for non-reads using the ShortRead library from the Bioconductor package. 

### Contents 
- ReadMe: Project summary and intoduction
- Kang_FinalProject.md: The project report 
- Kang_SpartinaSNP.R: The raw R code used to develop the analysis, with comments
- Kang_FinalProjectJournal_CMB523.rmd: Project journal where background research, tutorials, project development, and dead-ends are documented





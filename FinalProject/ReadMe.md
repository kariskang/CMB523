## Comparing the frequency of short DNA sequences among coastal grass populations: A coding exercise for Basic Programing for Life Sciences (CMB 523)

### Introduction
Sea level rise (SLR) in the U.S. northeast is ~3-4 times the global average, increasing at a significantly higher rate than the Pacific or Gulf coasts (Boon, 2012; Sallenger et al., 2012) and compounding the ongoing loss of saltmarsh habitat caused by anthropogenic disturbance. New England has lost 37% of its original saltmarshes, with Rhode Island losing the greatest portion of marsh area among New England states at 53% (Bromberg & Bertness, 2005). Loss of saltmarsh habitat impacts not only ecosystem services such as carbon sequestration (Macreadie et al., 2021; Mcleod et al., 2011), hurricane mitigation (Narayan et al., 2017), wildlife habitat (zu Ermgassen et al., 2021), and nutrient cycling (de Groot et al., 2012), but also jeopardizes genetic diversity in the coastal grasses that serve as ecosystem engineers for these systems. When genetic diversity is lost through reduction of population size (Zambrano et al., 2019), evolutionary potential for adaptation is diminished and can reduce a population’s ability to respond to rapid environmental change (Kramer & Haven, 2009). Thus understanding the level of genetic diversity both within and among populations is essential for coastal management when considering which populations to prioritize for conservation, which populations seed should be sourced when attempting to revegete degraded marshes, and planning for long-term population resilience in the face of climate change. 

*Spartina alterniflora*, also know as *Sporobolus alterniflora*, is a dominant low-marsh plant found in the most heavily indunated seaward edge of the marsh. Previous studies have found significant levels of within-population genetic diversity (Hughes & Lotterhos, 2014) and genetic differentiation among populations (Blum). A recent study by [Zerebecki et al. 2021](https://www.journals.uchicago.edu/doi/full/10.1086/716512?casa_token=81ZmvLXFw6QAAAAA%3Abp0plFHqk9asQU_zYnUOOeXsb5AG42Zo3xZRHV_xrFY7GyrK--ZhA_AsE_KaiJzHTbcVhEhF) used SNP analysis to compare *Spartina* populations from eleven marshes in Massachusetts, New Hampshire, Rhode Island, North Carolina, South Carolina, and Florida. While the study itself looked at differentation between two distinct *Spartina* forms, tall- and short-form, as seen across populations, for the purposes of this project I am looking at differentiation across populations in order familiarize myself with R packages used in SNP analysis and to apply coding skills learned in this class to datasets relevant to my area of research. 

### Data 
All *Spartina* RADseq data was downloaded from the [study's page on GenBank](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA733197) as FASTQ files. Five samples were chosen from a single site in New Hampshire and five from a single site in North Carolina, as cross referenced with the biosample data available; because tall- or short-form identifying data could not be found through the database, I opted to go with two sites (NH1 and NC1) where the form had been classified as "unidentified", rather than risk comparing sites from which two distinct types of *Spartina* had been collected. FASTQ files were imported and filtered for non-reads using the [ShortRead library from the Bioconductor package](https://bioconductor.org/packages/release/bioc/html/ShortRead.html). 

#### Samples: 
__New Hampshire:__
Site: Great Bay, NH 
Year: 2012
LatLong: 43.091489 N 70.864721 W

Sample name: Spartina_NHH_010; File name: SRR14677000.fastq.gz; BioSample: SAMN19370416; SRA: SRS9088595
Sample name: Spartina_NHH_012; File name: SRR14677304.fastq.gz; BioSample: SAMN19370418; SRA: SRS9088291
Sample name: Spartina_NHH_015; File name: SRR14677301.fastq.gz; BioSample: SAMN19370421; SRA: SRS9088294
Sample name: Spartina_NHH_019; File name: SRR14677297.fastq.gz; BioSample: SAMN19370425; SRA: SRS9088298
Sample name: Spartina_NHH_020; File name: SRR14677296.fastq.gz; BioSample: SAMN19370426; SRA: SRS9088299

__North Carolina:__
Site: Middle Marsh, North Carolina
Year 2012 
LatLong: 34.689328 N 76.621075 W

Sample name: Spartina_NCC_018; File name: SRR14677011.fastq.gz; BioSample: SAMN19370406; SRA: SRS9088584 
Sample name: Spartina_NCC_015; File name: SRR14677013.fastq.gz; BioSample: SAMN19370404; SRA: SRS9088582
Sample name: Spartina_NCC_012; File name: SRR14677014.fastq.gz; BioSample: SAMN19370403; SRA: SRS9088581
Sample name: Spartina_NCC_007; File name: SRR14677018.fastq.gz; BioSample: SAMN19370399; SRA: SRS9088577
Sample name: Spartina_NCC_017; File name: SRR14677012.fastq.gz; BioSample: SAMN19370405; SRA: SRS9088583

### Methods 
A random target sequence of 10 bp long was chosen from the cleaned sequence read for Spartina_NHH_010. A grep function was then used to count how many fragments in each sample contained that target sequence for samples in NH and NC. The proportion of fragments with the the target sequence were stored in a csv file and plotted using ggplot. Code can be found in Kang_SpartinaSNP.R
### Summary of Results 

### Contents 
- ReadMe: Project intoduction and summary
- Kang_SpartinaSNP.R: The raw R code used to develop the analysis, with comments
- Kang_FinalProjectJournal_CMB523.rmd: Project journal where background research, tutorials, project development, and dead-ends are documented

### References 
Boon, J. D. (2012). Evidence of sea level acceleration at US and Canadian tide stations, Atlantic Coast, North America. Journal of Coastal Research, 28(6), 1437-1445.

Bromberg, K. D., & Bertness, M. D. (2005). Reconstructing New England salt marsh losses using historical maps. Estuaries, 28, 823-832.

De Groot, R., Brander, L., Van Der Ploeg, S., Costanza, R., Bernard, F., Braat, L., Christie, M., Crossman, N., Ghermandi, A., Hein, L., Hussain, S., Kumar, P., McVittie, A., Portela, R., Rodriguez, L. C., ten Brink, P., & Van Beukering, P. (2012). Global estimates of the value of ecosystems and their services in monetary units. Ecosystem services, 1(1), 50-61.

Hughes, A. R., & Lotterhos, K. E. (2014). Genotypic diversity at multiple spatial scales in the foundation marsh species, Spartina alterniflora. Marine Ecology Progress   Series, 497, 105-117.

Kramer, A. T., & Havens, K. (2009). Plant conservation genetics in a changing world. Trends in plant science, 14(11), 599-607.
Macreadie, P. I., Costa, M. D., Atwood, T. B., Friess, D. A., Kelleway, J. J., Kennedy, H., Lovelock, C. E., Serrano, O., & Duarte, C. M. (2021). Blue carbon as a natural climate solution. Nature Reviews Earth & Environment, 2(12), 826-839.

Mcleod, E., Chmura, G. L., Bouillon, S., Salm, R., Björk, M., Duarte, C. M., Lovelock, C. E., Schlesinger, W. H., & Silliman, B. R. (2011). A blueprint for blue carbon: toward an improved understanding of the role of vegetated coastal habitats in sequestering CO2. Frontiers in Ecology and the Environment, 9(10), 552-560.

Narayan, S., Beck, M. W., Wilson, P., Thomas, C. J., Guerrero, A., Shepard, C. C., Reguero, B. G., Franco, G., Ingram, J. C., & Trespalacios, D. (2017). The value of coastal wetlands for flood damage reduction in the northeastern USA. Scientific reports, 7(1), 9463.

Sallenger Jr, A. H., Doran, K. S., & Howd, P. A. (2012). Hotspot of accelerated sea-level rise on the Atlantic coast of North America. Nature Climate Change, 2(12), 884-888.
Zambrano, J., Garzon-Lopez, C. X., Yeager, L., Fortunel, C., Cordeiro, N. J., & Beckman, N. G. (2019). The effects of habitat loss and fragmentation on plant functional traits and functional diversity: what do we know so far? Oecologia, 191, 505-518.

Zerebecki, R. A., Sotka, E. E., Hanley, T. C., Bell, K. L., Gehring, C., Nice, C. C., ... & Hughes, A. R. (2021). Repeated genetic and adaptive phenotypic divergence across tidal elevation in a foundation plant species. The American Naturalist, 198(5), E152-E169.

zu Ermgassen, P. S., Baker, R., Beck, M. W., Dodds, K., zu Ermgassen, S. O., Mallick, D., Taylor, M.D., & Turner, R. E. (2021). Ecosystem services: Delivering decision-making for salt marshes. Estuaries and Coasts, 44(6), 1691-1698.

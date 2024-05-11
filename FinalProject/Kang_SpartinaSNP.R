#import ShortRead library
library(ShortRead)

#import fastq files for New Hampshire samples of Spartina 
NH10<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
             pattern = 'SRR14677000.fastq.gz', withIds = T)
NH15<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
              pattern = 'SRR14677301.fastq.gz', withIds = T)
NH20<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
                pattern = 'SRR14677296.fastq.gz', withIds = T)
NH19<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
                pattern = 'SRR14677297.fastq.gz', withIds = T)
NH12<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
                pattern = 'SRR14677304.fastq.gz', withIds = T)

#filter out non-reads from imported sequences
clean_NH10<-clean(NH10)
clean_NH15<-clean(NH15)
clean_NH20<-clean(NH20)
clean_NH19<-clean(NH19)
clean_NH12<-clean(NH12)

#find a random nucleotide snippet to use as my "search term" 
sread(NH10)[1000] #inspect sequence on the 1000th RADseq fragment

#manually tested different sequence lengths <50 bp using grep code below;found 10 bp to be a sweetspot
snip<-"TTGGACTAAT" #random 10 bp target sequence taken from sample NH10
snipwidth<- nchar(snip) #stores length of target sequence; helpful as I was changing bp length during testing

#spent several hours attempting to write a loop function that would automatically return 
#the number of fragments which had my target sequence in a fastq file proportional to total fragment number

#for the sake of getting things done before the presentation, I ended up calling them all manually
#then storing the returned values in a separate csv

#Pre-Presentation grep coding for NH samples:
#both proportion and straight number of fragments with target sequence returned so I could compare them

#NH10
length(grep(snip, narrow(sread(clean_NH10), 
                              start = 1, width = snipwidth)))/length(clean_NH10) #gives proportion of fragments with search term
grep(snip, narrow(sread(clean_NH10), 
                   start = 1, width = snipwidth)) #gives straight number of fragments with search term

#NH15
length(grep(snip, narrow(sread(clean_NH15), 
                         start = 1, width = snipwidth)))/length(clean_NH15)
grep(snip, narrow(sread(clean_NH15), 
                  start = 1, width = snipwidth))
#NH20
length(grep(snip, narrow(sread(clean_NH20), 
                         start = 1, width = snipwidth)))/length(clean_NH20)
grep(snip, narrow(sread(clean_NH20), 
                  start = 1, width = snipwidth))
#NH19
length(grep(snip, narrow(sread(clean_NH19), 
                         start = 1, width = snipwidth)))/length(clean_NH19)
grep(snip, narrow(sread(clean_NH19), 
                  start = 1, width = snipwidth))
#NH12
length(grep(snip, narrow(sread(clean_NH12), 
                         start = 1, width = snipwidth)))/length(clean_NH12)
grep(snip, narrow(sread(clean_NH12), 
                  start = 1, width = snipwidth))


#Import North Carolina samples

NC18<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
                      pattern = 'SRR14677011.fastq.gz', withIds = T)
NC15<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
                pattern = 'SRR14677013.fastq.gz', withIds = T)
NC10<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
                pattern = 'SRR14677015.fastq.gz', withIds = T)
NC12<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
                pattern = 'SRR14677014.fastq.gz', withIds = T)
NC7<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
               pattern = 'SRR14677018.fastq.gz', withIds = T)
NC17<-readFastq(dirPath = "../Final Project/Zerebecki FASTQ", 
              pattern = 'SRR14677012.fastq.gz', withIds = T)

#Clean NC samples
clean_NC18<-clean(NC18)
clean_NC15<-clean(NC15)
clean_NC10<-clean(NC10)
clean_NC12<-clean(NC12)
clean_NC7<-clean(NC7)
clean_NC17<-clean(NC17)

#Pre-presentation grep coding for NC samples: 

#NC18
length(grep(snip, narrow(sread(clean_NC18), 
                         start = 1, width = snipwidth)))/length(clean_NC18)
grep(snip, narrow(sread(clean_NC18), 
                  start = 1, width = snipwidth))

#NC15
length(grep(snip, narrow(sread(clean_NC15), 
                         start = 1, width = snipwidth)))/length(clean_NC15)
grep(snip, narrow(sread(clean_NC15), 
                  start = 1, width = snipwidth))

#NC12
length(grep(snip, narrow(sread(clean_NC12), 
                         start = 1, width = snipwidth)))/length(clean_NC12)
grep(snip, narrow(sread(clean_NC12), 
                  start = 1, width = snipwidth))

#NC7
length(grep(snip, narrow(sread(clean_NC7), 
                         start = 1, width = snipwidth)))/length(clean_NC7)
grep(snip, narrow(sread(clean_NC7), 
                  start = 1, width = snipwidth))
#NC17
length(grep(snip, narrow(sread(clean_NC17), 
                         start = 1, width = snipwidth)))/length(clean_NC17)
grep(snip, narrow(sread(clean_NC17), 
                  start = 1, width = snipwidth))

#import csv where data from above was stored
subsample<-read.csv("TTGGACTAAT_subsamplecount.csv")

#plot proportion of fragments with target sequence against "Site"
library(ggplot2)
ggplot(subsample, aes(site, seqprop))+geom_point()+
  xlab("Site")+ylab("Proportion of Fragments with Target Sequence")+
  theme_bw()
#plot total number of DNA fragments for each sample against "Site"  
ggplot(subsample, aes(site, fragcount))+geom_point()+
  xlab("Site")+ylab("Number of DNA fragments")+
  theme_bw()

#Post-Presentation Coding: 
#ANOVA 
proportion<-aov(seqprop ~ site, data = subsample)
summary(proportion) #P-value is 0.973, really no difference in frequency of target sequence among sites

fragments<-aov(fragcount ~ site, data = subsample)
summary(fragments) #P-value is 0.136, no difference in number of fragments among sites

#I try for one last time to make this loop work before turning this in
NHsamples <-c(clean_NH10, clean_NH12, clean_NH15, clean_NH19, clean_NH20)
seq <- "TTGGACTAAT"
seqfreq<-function(samples, targetseq){
  for(i in samples){
    freqcount<- grep(targetseq, narrow(sread(samples), 
                      start = 1, width = nchar(targetseq)))
  }
  print(freqcount)
}
seqfreq(NHsamples, seq)
#nope, no happening

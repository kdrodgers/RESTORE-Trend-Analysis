library(akqdecay)


load(DV20180215.RData)
KirksTrendSites <- dvoverlap(DV, begyr=1950, endyr=2015, type="wyear", silent=FALSE)
length(KirksTrendSites)
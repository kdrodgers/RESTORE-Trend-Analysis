library(akqdecay)

###################################################################################

#load RData, .RDS, csv or Excel spreadsheet
load(DV20180215neg2zero.RData)

#code to determine which sites in the .RData file have a complete period of record based on begyr and endyr
KirksTrendSites <- dvoverlap(DV, begyr=1950, endyr=2015, type="wyear", silent=FALSE)

#code calculates the number of sites which match the criteria from line 9
length(KirksTrendSites)
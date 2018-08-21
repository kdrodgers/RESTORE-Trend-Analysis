library("dataRetrieval")
library("tidyverse")
library("Kendall")
library("EflowStats")
library("dplyr")
library("lubridate")
library("zoo")
library("xts")
library("boot")
library("xlsx")
library("trend")
library("smwrBase")
library("broom")
library("rkt")
library("zyp")
library("EGRET")
library("glue")

#####################################################################################
#loop to create pdf containing Quantile Kendall plots, output results, and export to Excel spreadsheet
#with site numbers on tabs of spreadsheet using code from Bob Hirsh for Quantile Kendall plots based on climate year
#and to save output as a .RDS file

pdf(file = "Winter4_1949_results.pdf")
for (i in 1:length(site_vec1)) {
  cat("\n",i,site_vec1[i]) 
  Daily <- readNWISDaily(site_vec1[i], parameterCd = "00060", 
                         startDate= "1949-04-01", endDate= "2016-03-31", convert = FALSE)
  INFO <- readNWISInfo(site_vec1[i],"", interactive=FALSE)
  eList <- as.egret(INFO, Daily, NA, NA)
  #results
  results <- plotQuantileKendall(eList, paStart = 1,
                                 paLong = 3,startDate= "1949-04-01", endDate= "2016-03-31",legendLocation = NA )
  #fileName <- paste("QK_results_1969.", site_vec1[i],".RDS", sep="")
  #saveRDS(results, file = fileName)
  write.xlsx(results, file = "Winter4_QK_results_1949.xls",
             sheetName = site_vec1[i], append = TRUE)
}
dev.off()
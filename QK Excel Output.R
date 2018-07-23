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


pdf(file = "April_1999_results.pdf")
for (i in 1:length(site_vec1)) {
  cat("\n",i,site_vec1[i]) 
  Daily <- readNWISDaily(site_vec1[i], parameterCd = "00060", 
                         startDate= "1999-04-01", endDate= "2016-03-31", convert = FALSE)
  INFO <- readNWISInfo(site_vec1[i],"", interactive=FALSE)
  eList <- as.egret(INFO, Daily, NA, NA)
  #results
  results <- plotQuantileKendallResults(eList, startDate = "1999-04-01", endDate = "2016-03-31", paStart = 4,
                                        paLong = 12,legendLocation = NA )
  fileName <- paste("QK_results.", site_vec1[i],".RDS", sep="")
  write.xlsx(results, file = "QK Results 1999.xls",
             sheetName = site_vec1[i], append = TRUE)
}
dev.off()
library("foreach")
library("doParallel")
library("tidyverse")
library("dataRetrieval")
library("Kendall")
library("EflowStats")
library("dplyr")
library("lubridate")
library("zoo")
library("xts")
library("boot")
library("xlsx")
library("trend")


setwd("F:/RESTORE/major_tasks/trends")
getwd()

###############################################
sitesAll <- ls(DV)

# sites <- sitesAll[!sitesAll %in% sitesOut]



#####################################
# loop to evalute which sites have weird number of column 

# colDF_tot <- data.frame()

colDF_10 <- data.frame()

colDF_XX <- data.frame()

obsDat_10 <- data.frame()

obsDat_XX <- data.frame()


for (x in sitesAll) {
  
  # df for each site number
  dfnew <- as.data.frame(DV[[x]])
  
  # number of columns in dfnew
  colnum <- ncol(dfnew)
  
  # # dataframe with site_no and number of columns
  # 
  # colDF_new <- data.frame(site_no = x, Ncol = colnum)
  # 
  # # bind rows
  # colDF_tot <- bind_rows(colDF_tot, colDF_new) #; rm(colDF_new)
  
  
  
  if (colnum == 10) {
    
    obsDat_10 <- bind_rows(obsDat_10, dfnew)
    
    colDF_10_new <- data.frame(site_no = x, Ncol = colnum)
    
    colDF_10 <- bind_rows(colDF_10, colDF_10_new)
    
    
  } else {
    
    obsDat_XX <- bind_rows(obsDat_XX, dfnew)
    
    colDF_XX_new <- data.frame(site_no = x, Ncol = colnum)
    
    colDF_XX <- bind_rows(colDF_XX, colDF_XX_new)
    
  }
  
  rm(dfnew, colnum, colDF_10_new, colDF_XX_new)
  
}

saveRDS(obsDat3, "obsDat3.RDS")


write.csv(obsDat3, "obsDat3.csv")



#####################
# # create empty dataframe
# colDF_new <- data.frame()
# 
# 
# for (x in sitesAll[1:2]) {
#   
#   # df for each site number
#   dfnew <- as.data.frame(DV[[x]])
#   
#   # number of columns in dfnew
#   colnum <- ncol(dfnew)
#   
#   # dataframe with site_no and number of columns
#   colDF <- data.frame(site_no = x, Ncol = colnum)
#   
#   # bind rows
#   colDF_new <- bind_rows(colDF_new, colDF); rm(colDF)
#   
# }


# #############################################
# # new dataframes filtering by number of columns
# colDF_10 <- filter(colDF_new, Ncol == 10)
# 
# colDF_XX <- filter(colDF_new, Ncol != 10)
# 
# # list of site_no with weird number of columns
# sitesOut <- as.character(colDF_XX$site_no)
# 
# # list of site_no with correct number of columns
# sites <- as.character(colDF_10$site_no)
# 


# ########################################
# # loop to create dataframe for 'sites' from DV environment 
# 
# cl <- makePSOCKcluster(detectCores() - 4)
# 
# clusterEvalQ(cl, library(foreach)); registerDoParallel(cl)
# 
# 
# 
# # create empty dataframe
# obsDat3 <- data.frame()
# 
# # loop to pulling each site from DV environment and cbinding to one MASSIVE dataframe 
# for (x in sites) {
#   
#   dfnew <- as.data.frame(DV[[x]])
#   
#   obsDat3 <- bind_rows(obsDat3, dfnew); rm(dfnew)
#   
# }
# 
# 
# stopCluster(cl)

saveRDS(obsDat3, "obsDat3.RDS")


write.csv(obsDat3, "obsDat3.csv")

  
##############################

#subset by sitesAll (from POR1950_2015) for final dataframe
subset(obsDat_Final, site_no %in% sitesAll)

# ###################
# # create empty dataframe
# dfOut <- data.frame()
# 
# # loop to pulling each site from DV environment and cbinding to one MASSIVE dataframe 
# for (x in sitesOut) {
#   
#   dfnew <- as.data.frame(DV[[x]])
#   
#   dfOut <- bind_rows(dfOut, dfnew); rm(dfnew)
#   
# }
# 
# length(unique(dfOut$site_no))










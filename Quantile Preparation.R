library("foreach")
library("doParallel")
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
library("akqdecay")
library("waterData")


########################################################################################

#code to calculate quantile 00 to 100 from obsDat_2015Final_4_5_2018
Quantile_Final <- obsDat_2015Final_4_5_2018 %>% 
  group_by(site_no, wyear) %>%
  summarize(q00 = quantile(x = Flow, probs = 0.0, na.rm = T, names = TRUE, type = 3),
            q10 = quantile(x = Flow, probs = 0.1, na.rm = T, names = TRUE, type = 3),
            q20 = quantile(x = Flow, probs = 0.2, na.rm = T, names = TRUE, type = 3),
            q30 = quantile(x = Flow, probs = 0.3, na.rm = T, names = TRUE, type = 3),
            q40 = quantile(x = Flow, probs = 0.4, na.rm = T, names = TRUE, type = 3),
            q50 = quantile(x = Flow, probs = 0.5, na.rm = T, names = TRUE, type = 3),
            q60 = quantile(x = Flow, probs = 0.6, na.rm = T, names = TRUE, type = 3),
            q70 = quantile(x = Flow, probs = 0.7, na.rm = T, names = TRUE, type = 3),
            q80 = quantile(x = Flow, probs = 0.8, na.rm = T, names = TRUE, type = 3),
            q90 = quantile(x = Flow, probs = 0.9, na.rm = T, names = TRUE, type = 3),
            q100 = quantile(x = Flow, probs = 1.0, na.rm = T, names = TRUE, type = 3))

#create Quantile dataframes from Quantile_Final
Q00 <- Quantile_Final[,c(1:3)]
Q10 <- Quantile_Final[,c(1:2,4)]
Q20 <- Quantile_Final[,c(1,2,5)]
Q30 <- Quantile_Final[,c(1,2,6)]
Q40 <- Quantile_Final[,c(1,2,7)]
Q50 <- Quantile_Final[,c(1,2,8)]
Q60 <- Quantile_Final[,c(1,2,9)]
Q70 <- Quantile_Final[,c(1,2,10)]
Q80 <- Quantile_Final[,c(1,2,11)]
Q90 <- Quantile_Final[,c(1,2,12)]
Q100 <- Quantile_Final[,c(1,2,13)]

#change column names in Q10-Q90 dataframes
colnames(Q00)[3] <- c("meanFlow") 
colnames(Q10)[3] <- c("meanFlow") 
colnames(Q20)[3] <- c("meanFlow") 
colnames(Q30)[3] <- c("meanFlow") 
colnames(Q40)[3] <- c("meanFlow") 
colnames(Q50)[3] <- c("meanFlow") 
colnames(Q60)[3] <- c("meanFlow") 
colnames(Q70)[3] <- c("meanFlow") 
colnames(Q80)[3] <- c("meanFlow") 
colnames(Q90)[3] <- c("meanFlow") 
colnames(Q100)[3] <- c("meanFlow") 

#add month to Quantile dataframe
Q00$month <- c("06")
Q10$month <- c("06")
Q20$month <- c("06")
Q30$month <- c("06")
Q40$month <- c("06")
Q50$month <- c("06")
Q60$month <- c("06")
Q70$month <- c("06")
Q80$month <- c("06")
Q90$month <- c("06")
Q100$month <- c("06")

#add day to Quantile dataframe
Q00$day <- c("15")
Q10$day <- c("15")
Q20$day <- c("15")
Q30$day <- c("15")
Q40$day <- c("15")
Q50$day <- c("15")
Q60$day <- c("15")
Q70$day <- c("15")
Q80$day <- c("15")
Q90$day <- c("15")
Q100$day <- c("15")

#adds column for group for Quantile
Q00_1950$Group <- c("Q00_")
Q10$Group <- c("Q10_")
Q20$Group <- c("Q20_")
Q30$Group <- c("Q30_")
Q40$Group <- c("Q40_")
Q50$Group <- c("Q50_")
Q60$Group <- c("Q60_")
Q70$Group <- c("Q70_")
Q80$Group <- c("Q80_")
Q90$Group <- c("Q90_")
Q100$Group <- c("Q100_")

# rename columns in Quantile dataframes
colnames(Q00)[2]<-c("wyear")
colnames(Q10)[2]<-c("wyear")
colnames(Q20)[2]<-c("wyear")
colnames(Q30)[2]<-c("wyear")
colnames(Q40)[2]<-c("wyear")
colnames(Q50)[2]<-c("wyear")
colnames(Q60)[2]<-c("wyear")
colnames(Q70)[2]<-c("wyear")
colnames(Q80)[2]<-c("wyear")
colnames(Q90)[2]<-c("wyear")
colnames(Q100)[2]<-c("wyear")

#combine WY, day, and month into a Date column for timeseries (Have to change the column header to make work)
Q00$Date <- paste(Q00$month,Q00$day,Q00$wyear,sep="-")
Q10$Date <- paste(Q10$month,Q10$day,Q10$wyear,sep="-")
Q20$Date <- paste(Q20$month,Q20$day,Q20$wyear,sep="-")
Q30$Date <- paste(Q30$month,Q30$day,Q30$wyear,sep="-")
Q40$Date <- paste(Q40$month,Q40$day,Q40$wyear,sep="-")
Q50$Date <- paste(Q50$month,Q50$day,Q50$wyear,sep="-")
Q60$Date <- paste(Q60$month,Q60$day,Q60$wyear,sep="-")
Q70$Date <- paste(Q70$month,Q70$day,Q70$wyear,sep="-")
Q80$Date <- paste(Q80$month,Q80$day,Q80$wyear,sep="-")
Q90$Date <- paste(Q90$month,Q90$day,Q90$wyear,sep="-")
Q100$Date <- paste(Q100$month,Q100$day,Q100$wyear,sep="-")

#format Date as.Date for Quantile dataframe
Q00$Date <- as.Date(Q00$Date, format="%m-%d-%Y")
Q10$Date <- as.Date(Q10$Date, format="%m-%d-%Y")
Q20$Date <- as.Date(Q20$Date, format="%m-%d-%Y")
Q30$Date <- as.Date(Q30$Date, format="%m-%d-%Y")
Q40$Date <- as.Date(Q40$Date, format="%m-%d-%Y")
Q50$Date <- as.Date(Q50$Date, format="%m-%d-%Y")
Q60$Date <- as.Date(Q60$Date, format="%m-%d-%Y")
Q70$Date <- as.Date(Q70$Date, format="%m-%d-%Y")
Q80$Date <- as.Date(Q80$Date, format="%m-%d-%Y")
Q90$Date <- as.Date(Q90$Date, format="%m-%d-%Y")
Q100$Date <- as.Date(Q100$Date, format="%m-%d-%Y")



###########################################################################################

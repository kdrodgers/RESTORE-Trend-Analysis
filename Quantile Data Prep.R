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
library("smwrBase")
library("broom")

#filter Quantile dataframe by wyear for decadal quantile dataframes
Quantile_Final_1950 <- Quantile_Final_4_5_2018
Quantile_Final_1960 <- filter(Quantile_Final_4_5_2018, wyear >= "1960")
Quantile_Final_1970 <- filter(Quantile_Final_4_5_2018, wyear >= "1970")
Quantile_Final_1980 <- filter(Quantile_Final_4_5_2018, wyear >= "1980")
Quantile_Final_1990 <- filter(Quantile_Final_4_5_2018, wyear >= "1990")
Quantile_Final_2000 <- filter(Quantile_Final_4_5_2018, wyear >= "2000")


#create Quantile dataframes from Quantile_Final
Q00_2000 <- Quantile_Final_2000[,c(1:3)]
Q10_1950 <- Quantile_Final_1950[,c(1:2,4)]
Q20_1950 <- Quantile_Final_1950[,c(1:2,5)]
Q30_1950 <- Quantile_Final_1950[,c(1,2,6)]
Q40_1950 <- Quantile_Final_1950[,c(1,2,7)]
Q50_1950 <- Quantile_Final_1950[,c(1,2,8)]
Q60_1950 <- Quantile_Final_1950[,c(1,2,9)]
Q70_1950 <- Quantile_Final_1950[,c(1,2,10)]
Q80_1950 <- Quantile_Final_1950[,c(1,2,11)]
Q90_1950 <- Quantile_Final_1950[,c(1,2,12)]
Q100_2000 <- Quantile_Final_2000[,c(1,2,13)]

#change column names in Q10-Q90 dataframes
colnames(Q10_1950)[3] <- c("meanFlow") 
colnames(Q20_1950)[3] <- c("meanFlow") 
colnames(Q30_1950)[3] <- c("meanFlow") 
colnames(Q40_1950)[3] <- c("meanFlow") 
colnames(Q50_1950)[3] <- c("meanFlow") 
colnames(Q60_1950)[3] <- c("meanFlow") 
colnames(Q70_1950)[3] <- c("meanFlow") 
colnames(Q80_1950)[3] <- c("meanFlow") 
colnames(Q90_1950)[3] <- c("meanFlow") 

#add month to Quantile dataframe
Q10_1950$month <- c("06")
Q20_1950$month <- c("06")
Q30_1950$month <- c("06")
Q40_1950$month <- c("06")
Q50_1950$month <- c("06")
Q60_1950$month <- c("06")
Q70_1950$month <- c("06")
Q80_1950$month <- c("06")
Q90_1950$month <- c("06")

#add day to Quantile dataframe
Q10_1950$day <- c("15")
Q20_1950$day <- c("15")
Q30_1950$day <- c("15")
Q40_1950$day <- c("15")
Q50_1950$day <- c("15")
Q60_1950$day <- c("15")
Q70_1950$day <- c("15")
Q80_1950$day <- c("15")
Q90_1950$day <- c("15")

#adds column for group for Quantile
Q10_1950$Group <- c("Q10_")
Q20_1950$Group <- c("Q20_")
Q30_1950$Group <- c("Q30_")
Q40_1950$Group <- c("Q40_")
Q50_1950$Group <- c("Q50_")
Q60_1950$Group <- c("Q60_")
Q70_1950$Group <- c("Q70_")
Q80_1950$Group <- c("Q80_")
Q90_1950$Group <- c("Q90_")

# rename columns in Quantile dataframes
colnames(Q10_1950)[2]<-c("wyear")
colnames(Q20_1950)[2]<-c("wyear")
colnames(Q30_1950)[2]<-c("wyear")
colnames(Q40_1950)[2]<-c("wyear")
colnames(Q50_1950)[2]<-c("wyear")
colnames(Q60_1950)[2]<-c("wyear")
colnames(Q70_1950)[2]<-c("wyear")
colnames(Q80_1950)[2]<-c("wyear")
colnames(Q90_1950)[2]<-c("wyear")

#combine WY, day, and month into a Date column for timeseries (Have to change the column header to make work)
Q10_1950$Date <- paste(Q10_1950$month,Q10_1950$day,Q10_1950$wyear,sep="-")
Q20_1950$Date <- paste(Q20_1950$month,Q20_1950$day,Q20_1950$wyear,sep="-")
Q30_1950$Date <- paste(Q30_1950$month,Q30_1950$day,Q30_1950$wyear,sep="-")
Q40_1950$Date <- paste(Q40_1950$month,Q40_1950$day,Q40_1950$wyear,sep="-")
Q50_1950$Date <- paste(Q50_1950$month,Q50_1950$day,Q50_1950$wyear,sep="-")
Q60_1950$Date <- paste(Q60_1950$month,Q60_1950$day,Q60_1950$wyear,sep="-")
Q70_1950$Date <- paste(Q70_1950$month,Q70_1950$day,Q70_1950$wyear,sep="-")
Q80_1950$Date <- paste(Q80_1950$month,Q80_1950$day,Q80_1950$wyear,sep="-")
Q90_1950$Date <- paste(Q90_1950$month,Q90_1950$day,Q90_1950$wyear,sep="-")

#format Date as.Date for Quantile dataframe
Q10_1950$Date <- as.Date(Q10_1950$Date, format="%m-%d-%Y")
Q20_1950$Date <- as.Date(Q20_1950$Date, format="%m-%d-%Y")
Q30_1950$Date <- as.Date(Q30_1950$Date, format="%m-%d-%Y")
Q40_1950$Date <- as.Date(Q40_1950$Date, format="%m-%d-%Y")
Q50_1950$Date <- as.Date(Q50_1950$Date, format="%m-%d-%Y")
Q60_1950$Date <- as.Date(Q60_1950$Date, format="%m-%d-%Y")
Q70_1950$Date <- as.Date(Q70_1950$Date, format="%m-%d-%Y")
Q80_1950$Date <- as.Date(Q80_1950$Date, format="%m-%d-%Y")
Q90_1950$Date <- as.Date(Q90_1950$Date, format="%m-%d-%Y")



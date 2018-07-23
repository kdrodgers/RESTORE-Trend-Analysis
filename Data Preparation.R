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


#######################################################


#create dataframe from master file to manipulate in code
SiteByMonth_1950 = obsDat_2015Final_4_5_2018


#average flow by month and site
SiteByMonthAve_1950 <- SiteByMonth_1950 %>% 
  group_by(site_no, wyear, month) %>%
  summarize(meanFlow = mean(Flow))
SiteByMonthAve_1950

#subset SiteByMonthAve by seasons
SitesBySpringAve_1950 <- filter(SiteByMonthAve_1950, month %in% c("4","5","6"))
SitesBySummerAve_1950 <- filter(SiteByMonthAve_1950, month %in% c("7","8","9"))
SitesByFall_1950 <- filter(SiteByMonthAve_1950, month %in% c("10","11","12"))
SitesByWinter_1950 <- filter(SiteByMonthAve_1950, month %in% c("1","2","3"))

#aggregates by season and then takes the mean of the values
SitesBySpringAve_1950 <- aggregate(SitesBySpringAve_1950$meanFlow ~ SitesBySpringAve_1950$wyear*SitesBySpringAve_1950$site_no, FUN = "mean")
SitesBySummerAve_1950 <- aggregate(SitesBySummerAve_1950$meanFlow ~ SitesBySummerAve_1950$wyear*SitesBySummerAve_1950$site_no, FUN = "mean")
SitesByFallAve_1950 <- aggregate(SitesByFallAve_1950$meanFlow ~ SitesByFallAve_1950$wyear*SitesByFallAve_1950$site_no, FUN = "mean")
SitesByWinterAve_1950 <- aggregate(SitesByWinterAve_1950$meanFlow ~ SitesByWinterAve_1950$wyear*SitesByWinterAve_1950$site_no, FUN = "mean")

#rename columns in SeasonAve dataframes
colnames(SitesBySpringAve_1950)[1:3] <- c("wyear", "site_no", "meanFlow") 
colnames(SitesBySummerAve_1950)[1:3] <- c("wyear","site_no", "meanFlow") 
colnames(SitesByFallAve_1950)[1:3] <- c("wyear","site_no", "meanFlow") 
colnames(SitesByWinterAve_1950)[1:3] <- c("wyear","site_no", "meanFlow")


#adds column for month and date to create "Date" variable for timeseries
SitesBySpringAve_1950$month <- c("05")
SitesBySpringAve_1950$day <- c("15")
SitesBySummerAve_1950$month <- c("08")
SitesBySummerAve_1950$day <- c("15")
SitesByFallAve_1950$month <- c("11")
SitesByFallAve_1950$day <- c("15")
SitesByWinterAve_1950$month <- c("02")
SitesByWinterAve_1950$day <- c("15")



#adds column for season and a season variable (i.e. Spring, Summer, Winter, Fall
SitesBySpringAve_1950$Group <- c("Spring_")
SitesBySummerAve_1950$Group <- c("Summer_")
SitesByFallAve_1950$Group <- c("Fall_")
SitesByWinterAve_1950$Group <- c("Winter_")


#combine WY, day, and month into a Date column for timeseries (Have to change the column header to make work)
SitesBySpringAve_1950$Date <- paste(SitesBySpringAve_1950$month,SitesBySpringAve_1950$day,SitesBySpringAve_1950$wyear,sep="-")
SitesBySummerAve_1950$Date <- paste(SitesBySummerAve_1950$month,SitesBySummerAve_1950$day,SitesBySummerAve_1950$wyear,sep="-")
SitesByFallAve_1950$Date <- paste(SitesByFallAve_1950$month,SitesByFallAve_1950$day,SitesByFallAve_1950$wyear,sep="-")
SitesByWinterAve_1950$Date <- paste(SitesByWinterAve_1950$month,SitesByWinterAve_1950$day,SitesByWinterAve_1950$wyear,sep="-")


#Converts "Date" as.character to "Date" as.Date
SitesBySpringAve_1950$Date <- as.Date(SitesBySpringAve_1950$Date, format="%m-%d-%Y")
SitesBySummerAve_1950$Date <- as.Date(SitesBySummerAve_1950$Date, format="%m-%d-%Y")
SitesByFallAve_1950$Date <- as.Date(SitesByFallAve_1950$Date, format="%m-%d-%Y")
SitesByWinterAve_1950$Date <- as.Date(SitesByWinterAve_1950$Date, format="%m-%d-%Y")

# subsets sites by month
SiteByMonthAve_Jan_1950 <- filter(SiteByMonthAve_1950, month %in% c("1"))
SiteByMonthAve_Feb_1950 <- filter(SiteByMonthAve_1950, month %in% c("2"))
SiteByMonthAve_Mar_1950 <- filter(SiteByMonthAve_1950, month %in% c("3"))
SiteByMonthAve_Apr_1950 <- filter(SiteByMonthAve_1950, month %in% c("4"))
SiteByMonthAve_May_1950 <- filter(SiteByMonthAve_1950, month %in% c("5"))
SiteByMonthAve_Jun_1950 <- filter(SiteByMonthAve_1950, month %in% c("6"))
SiteByMonthAve_Jul_1950 <- filter(SiteByMonthAve_1950, month %in% c("7"))
SiteByMonthAve_Aug_1950 <- filter(SiteByMonthAve_1950, month %in% c("8"))
SiteByMonthAve_Sep_1950 <- filter(SiteByMonthAve_1950, month %in% c("9"))
SiteByMonthAve_Oct_1950 <- filter(SiteByMonthAve_1950, month %in% c("10"))
SiteByMonthAve_Nov_1950 <- filter(SiteByMonthAve_1950, month %in% c("11"))
SiteByMonthAve_Dec_1950 <- filter(SiteByMonthAve_1950, month %in% c("12"))

#add day to SiteByMontAve_Month
SiteByMonthAve_Jan_1950$day <- c("15")
SiteByMonthAve_Feb_1950$day <- c("15")
SiteByMonthAve_Mar_1950$day <- c("15")
SiteByMonthAve_Apr_1950$day <- c("15")
SiteByMonthAve_May_1950$day <- c("15")
SiteByMonthAve_Jun_1950$day <- c("15")
SiteByMonthAve_Jul_1950$day <- c("15")
SiteByMonthAve_Aug_1950$day <- c("15")
SiteByMonthAve_Sep_1950$day <- c("15")
SiteByMonthAve_Oct_1950$day <- c("15")
SiteByMonthAve_Nov_1950$day <- c("15")
SiteByMonthAve_Dec_1950$day <- c("15")

#Add Group column to 1950 dataframe
SiteByMonthAve_Jan_1950$Group <- c("Jan_")
SiteByMonthAve_Feb_1950$Group <- c("Feb_")
SiteByMonthAve_Mar_1950$Group <- c("Mar_")
SiteByMonthAve_Apr_1950$Group <- c("Apr_")
SiteByMonthAve_May_1950$Group <- c("May_")
SiteByMonthAve_Jun_1950$Group <- c("Jun_")
SiteByMonthAve_Jul_1950$Group <- c("Jul_")
SiteByMonthAve_Aug_1950$Group <- c("Aug_")
SiteByMonthAve_Sep_1950$Group <- c("Sep_")
SiteByMonthAve_Oct_1950$Group <- c("Oct_")
SiteByMonthAve_Nov_1950$Group <- c("Nov_")
SiteByMonthAve_Dec_1950$Group <- c("Dec_")


#combine WY, day, and month into a Date column for timeseries (Have to change the column header to make work)
SiteByMonthAve_Jan_1950$Date <- paste(SiteByMonthAve_Jan_1950$month,SiteByMonthAve_Jan_1950$day,SiteByMonthAve_Jan_1950$wyear,sep="-")
SiteByMonthAve_Feb_1950$Date <- paste(SiteByMonthAve_Feb_1950$month,SiteByMonthAve_Feb_1950$day,SiteByMonthAve_Feb_1950$wyear,sep="-")
SiteByMonthAve_Mar_1950$Date <- paste(SiteByMonthAve_Mar_1950$month,SiteByMonthAve_Mar_1950$day,SiteByMonthAve_Mar_1950$wyear,sep="-")
SiteByMonthAve_Apr_1950$Date <- paste(SiteByMonthAve_Apr_1950$month,SiteByMonthAve_Apr_1950$day,SiteByMonthAve_Apr_1950$wyear,sep="-")
SiteByMonthAve_May_1950$Date <- paste(SiteByMonthAve_May_1950$month,SiteByMonthAve_May_1950$day,SiteByMonthAve_May_1950$wyear,sep="-")
SiteByMonthAve_Jun_1950$Date <- paste(SiteByMonthAve_Jun_1950$month,SiteByMonthAve_Jun_1950$day,SiteByMonthAve_Jun_1950$wyear,sep="-")
SiteByMonthAve_Jul_1950$Date <- paste(SiteByMonthAve_Jul_1950$month,SiteByMonthAve_Jul_1950$day,SiteByMonthAve_Jul_1950$wyear,sep="-")
SiteByMonthAve_Aug_1950$Date <- paste(SiteByMonthAve_Aug_1950$month,SiteByMonthAve_Aug_1950$day,SiteByMonthAve_Aug_1950$wyear,sep="-")
SiteByMonthAve_Sep_1950$Date <- paste(SiteByMonthAve_Sep_1950$month,SiteByMonthAve_Sep_1950$day,SiteByMonthAve_Sep_1950$wyear,sep="-")
SiteByMonthAve_Oct_1950$Date <- paste(SiteByMonthAve_Oct_1950$month,SiteByMonthAve_Oct_1950$day,SiteByMonthAve_Oct_1950$wyear,sep="-")
SiteByMonthAve_Nov_1950$Date <- paste(SiteByMonthAve_Nov_1950$month,SiteByMonthAve_Nov_1950$day,SiteByMonthAve_Nov_1950$wyear,sep="-")
SiteByMonthAve_Dec_1950$Date <- paste(SiteByMonthAve_Dec_1950$month,SiteByMonthAve_Dec_1950$day,SiteByMonthAve_Dec_1950$wyear,sep="-")

#Converts "Date" as.character to "Date" as.Date for month
SiteByMonthAve_Jan_1950$Date <- as.Date(SiteByMonthAve_Jan_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Feb_1950$Date <- as.Date(SiteByMonthAve_Feb_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Mar_1950$Date <- as.Date(SiteByMonthAve_Mar_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Apr_1950$Date <- as.Date(SiteByMonthAve_Apr_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_May_1950$Date <- as.Date(SiteByMonthAve_May_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Jun_1950$Date <- as.Date(SiteByMonthAve_Jun_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Jul_1950$Date <- as.Date(SiteByMonthAve_Jul_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Aug_1950$Date <- as.Date(SiteByMonthAve_Aug_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Sep_1950$Date <- as.Date(SiteByMonthAve_Sep_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Oct_1950$Date <- as.Date(SiteByMonthAve_Oct_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Nov_1950$Date <- as.Date(SiteByMonthAve_Nov_1950$Date, format="%m-%d-%Y")
SiteByMonthAve_Dec_1950$Date <- as.Date(SiteByMonthAve_Dec_1950$Date, format="%m-%d-%Y")

#changes name from "WY" to "wyear"
colnames(SiteByMonthAve_Jan_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Feb_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Mar_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Apr_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_May_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Jun_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Jul_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Aug_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Sep_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Oct_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Nov_1950)[2]<-c("wyear")
colnames(SiteByMonthAve_Dec_1950)[2]<-c("wyear")
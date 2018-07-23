
# Explore  screened data

library(dplyr)
library(tidyr)
library(smwrBase)

# read in data
krQ <- readRDS("D:/Projects/RESTORE/data/obsDat_2015Final_4_25_2108.RDS")
krQ <- obsDat_2015Final_4_25_2018

qInfo <- krQ %>%
  group_by(site_no) %>%
  summarize(nObs = n(),
            startQ = min(Date),
            endQ = max(Date))

qInfo %>% ungroup() %>%
  summarize(nObs_min = min(nObs),
            nObs_max = max(nObs),
            startQ_min = min(startQ),
            startQ_max = max(startQ),
            endQ_min = min(endQ),
            endQ_max = max(endQ))

# start & end dates look good
# but not sure why there's a difference in the number of days...
# even though this difference is only ~ 7 days

qInfo %>%
  filter(nObs != 24106)
# So there are 10 sites that have a 1 or more missing rows

# Let's take a look
temp <- filter(krQ, site_no == "08198000")
temp %>% filter(is.na(Flow))
  #so, there are no NA values for flow...

# Are there rows that are missing entirely?
temp$Date_lag <- c(as.Date(NA), temp$Date[1:length(temp$Date)-1])
temp <- temp %>%
  mutate(Date_diff = Date - Date_lag)
temp %>% filter(Date_diff > 1)
  #ah ha! -- looks like this record has 2 missing rows:
  #no rows for: 2006-09-30 and 2006-10-01

# Can insert using insertMissing (smwrBase package)
temp_updated <- insertMissing(temp, "Date", fill = TRUE)

# Can then fill in Flow values (not using the function from waterData)
# fill using interpolation
temp_updated$Flow <- fillMissing(temp_updated$Flow)
temp_updated <- select(temp_updated, -Date_lag, -Date_diff) #remove processing columns

# Check if that worked
temp_updated %>%
  summarize(nObs = n(),
            startQ = min(Date),
            endQ = max(Date))
  #bingo! = 24106 obs is what we are looking for


#assigns temp_updated dataframe to a site number
site_08198000 <- temp_updated


#determine which rows need to be replaced
site_08198000 %>% filter(is.na(site_no))

#add values to row inserted where site number is the appropriate site number for the dataframe



site_08198000 <- temp_updated
site_08198000$agency_cd <- c("USGS")
site_08198000$site_no <- c("08198000")
site_08198000$Flow_cd <- c("A")
site_08198000$site <- c("08198000")
site_08198000$year <- c("2006")
site_08198000$decade <- c("2000")
site_08198000$wyear <- EflowStats::get_waterYear(site_08198000$Date, numeric = T)
site_08198000$Month <- months(as.Date(site_08198000$Date))
site_08198000$month = match(site_08198000$Month, month.name)
site_08198000$Month <- NULL

#check to see if blank values were replaced

site_08198000 %>% filter(is.na(Flow))

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

#create column combining NLCD LULC to determine percent coverage of LULC
GBC_Final$planted_cultivated <- GBC_Final$cultivated_cropland + GBC_Final$hay_pasture
GBC_Final$forest <- GBC_Final$deciduous_forest + GBC_Final$evergreen_forest + GBC_Final$mixed_forest

#calculation of NAWQA LULC based on percent coverage
GBC_Final$lulc_class[GBC_Final$planted_cultivated > 50 & GBC_Final$developed <= 5]<- "ag"
GBC_Final$lulc_class[GBC_Final$planted_cultivated <= 25 & GBC_Final$developed > 25]<- "urban"
GBC_Final$lulc_class[GBC_Final$planted_cultivated <= 25 & GBC_Final$developed <= 5]<- "undeveloped"
GBC_Final$lulc_class[GBC_Final$planted_cultivated > 25 & GBC_Final$planted_cultivated <= 50 & GBC_Final$developed > 5 & GBC_Final$developed < 25]<- "mixed"






if (GBC_Final$lulc_class == "ag") {
  statement1
} else if ( test_expression2) {
  statement2
} else if ( test_expression3) {
  statement3
} else {
  statement4
}


GBC_Final$lulc_class <- NULL

for (i in 1:nrow(GBC_Final)) {
  (GBC_Final$planted_cultivated[i] > 50 & GBC_Final$developed[i] <= 5) {
    GBC_Final$lulc_class[i] <- "ag"
  }
  else if(GBC_Final$planted_cultivated[i] <= 25 & GBC_Final$developed[i] > 25) {
    GBC_Final$lulc_class[i] <- "urban"
  }
  else if (GBC_Final$planted_cultivated[i] <= 25 & GBC_Final$developed[i] <= 5) {
    GBC_Final$lulc_class[i] <- "undeveloped"
  }
  else if (GBC_Final$planted_cultivated[i] > 25 & <= 50 & GBC_Final$developed > 5 & < 25) {
    GBC_Final$lulc_class[i] <- "mixed"
  }
}

length(resid(lm(mpg ~ cyl, test)))

nrow(GBC_Final)
#32
summary(GBC_FInal)

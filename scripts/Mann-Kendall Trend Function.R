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
library("readr")

##############################################################################################
#Final function used to run MannKendall Trend Analysis
testFun <- function(SitesBy_df) {
  
  sites <- unique(SitesBy_df$site_no)
  List = list() #creates an empty list we will fill with site, ken tau, and p value for future reference
  
  
  for (i in 1:length(sites)) {
    
    data.sub <- dplyr::filter(SitesBy_df, site_no == sites[i])
    
    x = xts(data.sub$meanFlow, data.sub$Date)
    
    ken.tau = MannKendall(x)
    sens.data = sens.slope(data.sub$meanFlow, conf.level = 0.95)
    List[[length(List)+1]] = data.frame(Site = data.sub$site_no, Tau = ken.tau$tau[1], Tau.p = ken.tau$sl[1], SensSlope = sens.data$estimate[1], Z = sens.data$statistic[1], Z.p = sens.data$p.value[1])#, Z.lower = sens.data$conf.int[1])#, Z.upper = sens.data$conf.int[2]) #fill list with 3 columns (site name, ken.tau, and p value)
    
    
    if(ken.tau$sl[1] < 0.05){ #if sig
      if(ken.tau$tau[1] > 0){ #and if postitive
        save.path <- file.path("C:","Users","krodgers","Desktop","Pos and sig",paste(SitesBy_df[,6], sites[i], ".pdf", sep = "")) #make path to save a plot called "plot_SITENAME.jpg" in the folder on the desktop called "Pos and sig"
        pdf(file = save.path)
        layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
        plot(data.sub$Date, data.sub$meanFlow, xlab="Year", ylab = "MeanFlow (in cfs)")
        lines(lowess(data.sub$meanFlow ~ data.sub$Date), col="blue")
        
        dev.off()
      }
      else{ #do this is neg and sig
        save.path <- file.path("C:","Users","krodgers","Desktop","Neg and sig",paste(SitesBy_df[,6], sites[i], ".pdf", sep = "")) #make path to save a plot called "plot_SITENAME.jpg" in the folder on the desktop called "Pos and sig"
        pdf(file = save.path)
        layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
        plot(data.sub$Date, data.sub$meanFlow, xlab="Year", ylab = "MeanFlow (in cfs)")
        title = paste(SitesBy_df[,6], sites[i])
        lines(lowess(data.sub$meanFlow ~ data.sub$Date), col="blue")
        
        dev.off()
      }
    }
    else{ #do this if not sig
      save.path <- file.path("C:","Users","krodgers","Desktop","Not sig",paste(SitesBy_df[,6], sites[i], ".pdf", sep = "")) #make path to save a plot called "plot_SITENAME.jpg" in the folder on the desktop called "Not sig"
      pdf(file = save.path)
      layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
      plot(data.sub$Date, data.sub$meanFlow, xlab="Year", ylab = "MeanFlow (in cfs)")
      title = paste(SitesBy_df[,6], sites[i])
      lines(lowess(data.sub$meanFlow ~ data.sub$Date), col="blue")
      dev.off()
    }
  }
  
  res.out <- plyr::ldply(List)
  tau.agg = aggregate(res.out$Tau ~ res.out$Site, FUN = "mean")
  p.agg = aggregate(res.out$Tau.p ~ res.out$Site, FUN = "mean")
  slope.agg = aggregate(res.out$SensSlope ~ res.out$Site, FUN = "mean")
  Z.agg = aggregate(res.out$Z ~ res.out$Site, FUN = "mean")
  p.z.agg = aggregate(res.out$Z.p ~ res.out$Site, FUN = "mean")
  res.out <- cbind(tau.agg[1], tau.agg[2], p.agg[2], slope.agg[2], Z.agg[2], p.z.agg[2])#, Z.lower.agg[2]), Z.upper.agg[2])
  colnames(res.out)[1:6] <- c("Site", "Tau", "Tau.p", "SensSlope", "Z", "Z.p")#, "Z.lower")#, "Z.upper")
  res.out.Sep_1990 <<- res.out
  
}  



testFun(SitesBySpringAve_1950) #be sure to change the season in the function :)
testFun(SitesBySummerAve_1950) #be sure to change the season in the function :)
testFun(SitesByFallAve_1950) #be sure to change the season in the function :)
testFun(SitesByWinterAve_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Jan_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Feb_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Mar_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_May_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_May_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Jun_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Jul_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Aug_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Sep_1990) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Oct_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Nov_1950) #be sure to change the season in the function :)
testFun(SiteByMonthAve_Dec_1950) #be sure to change the season in the function :)
testFun(Coastal.Sites)
testFun(Q00_1950)
testFun(Q10_1950)
testFun(Q20_1950)
testFun(Q30_1950)
testFun(Q40_1950)
testFun(Q50_1950)
testFun(Q60_1950)
testFun(Q70_1950)
testFun(Q80_1950)
testFun(Q90_1950)
testFun(Q100_1950)
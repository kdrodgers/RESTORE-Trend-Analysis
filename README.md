# RESTORE-Trend-Analysis
RESTORE Trend Analysis

README File for the RESTORE Trend Analysis

Contained within are files associated with the RESTORE Trend Analysis.
Included are three files entitled "scripts", "data", and "results."

Below is a brief description of the content contained in each folder:

File entitled "scripts":

DV to df_2-13-2018
Script designed to determine the number of sites with differing numbers of columns. 

Daily Value Overlap
Script to determine which sites in the .RData file have a complete period of record based on begyr and endyr. 

Data Preparation
Script creates dataframe from master file to manipulate in code and average flow by month and site. Subset dataframe by seasons and aggregates by season and takes the mean of the values. 

ExploreQData
Reads in data and check start & end dates to ensure they match designated beginning and ending dates. If number of days are different, calculates the difference in dates and the number of sites that do not match. 

FiveTrendGraphs
Loop to create pdf containing Quantile Kendall plots, output results, and export to Excel spreadsheet with site numbers on tabs of spreadsheet using code from Bob Hirsh for Quantile Kendall plots based on climate year and to save output as a .RDS file

Gage Basin Characteristics LULC
Script creates a column combining NLCD LULC to determine percent coverage of LULC with calculation of NAWQA LULC based on percent coverage.

Kirk Quantile Kendall
Scripts loops to create pdf containing Quantile Kendall plots, output results, and export to Excel spreadsheet with site numbers on tabs of spreadsheet using code from Bob Hirsh for Quantile Kendall plots based on climate year and to save output as a .RDS file.

Mann-Kendall Trend Function
Final function used to run Mann-Kendall Trend Analysis.

Quantile Data Preparation
Script filters Quantile dataframe by wyear for decadal quantile dataframes, creates Quantile dataframes from Quantile_Final, change column names in Q00-Q100 dataframes.

Results Output Excel
Script saves result output as Excel file.

Tibble to Dataframe
Script converts a tibble to a dataframe for analysis.

This software is preliminary or provisional and is subject to revision. It is being provided to meet the need for timely best science. The software has not received final approval by the U.S. Geological Survey (USGS). No warranty, expressed or implied, is made by the USGS or the U.S. Government as to the functionality of the software and related material nor shall the fact of release constitute any such warranty. The software is provided on the condition that neither the USGS nor the U.S. Government shall be held liable for any damages resulting from the authorized or unauthorized use of the software.
 
File entitled "data":

This file contains the data used in Mann-Kendall Trend Analysis and Quantile-Kendall Analysis in a RDS format. These datasets represent period of records (POR) beginning in 1950 and ending in 2015. In addition, inter-decadal POR datasets (i.e. 1960-2015; 1970-2015; 1980-2015; 1990-2015; and 2000-2015) are also included. 

File entitle "results":

This file contains the results from Mann-Kendall Trend Analysis and Quantile-Kendall Analysis in Excel spreadsheets. Results from the Mann-Kendall Trend Analysis are reported by period of record (POR) beginning in 1950 and ending in 2015. In addition, inter-decadal POR were analyzed (i.e. 1960-2015; 1970-2015; 1980-2015; 1990-2015; and 2000-2015). 

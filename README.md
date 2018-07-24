# RESTORE-Trend-Analysis
R scripts used in RESTORE Trend Analysis

README File for R scripts used in RESTORE Trend Analysis

DV to df_2-13-2018
Script designed to determine the number of sites with differing numbers of columns. Script creates and evaluates individual data frames. Data frames are then merged using “bind_rows” creating one large dataframe which is saved as a .RDS file and writes data to .csv file.

Daily Value Overlap
Script to determine which sites in the .RData file have a complete period of record based on begyr and endyr. The script calculates the number of sites which match beginning year (begyr) and ending year (endyr) .

Data Preparation
Script creates dataframe from master file to manipulate in code and average flow by month and site. Subset dataframe by seasons and aggregates by season and takes the mean of the values. Script renames columns in dataframes, adds column for month and date to create "Date" variable for timeseries. Script adds column for season and a season variable (i.e. Spring, Summer, Winter, Fall) and combines WY, day, and month into a Date column for timeseries converts "Date" as.character to "Date" as.Date. Script subsets sites by month, adds day to dataframe and adds group column to dataframe. Process is repeated for each dataframe in the analysis.

ExploreQData
Reads in data and check start & end dates to ensure they match designated beginning and ending dates. If number of days are different, calculates the difference in dates and the number of sites that do not match. In addition, the script determines if “NA” are present in dataset. If rows are missing from the record, the script determines the number of rows missing. The missing records can be inserted using insertMissing (smwrBase package) which fills in missing flow values using interpolation. Script assigns temp_updated dataframe to a site number to identify which rows need to be replaced and adds values to the inserted row and checks to insure blank values were replaced.

FiveTrendGraphs
Loop to create pdf containing Quantile Kendall plots, output results, and export to Excel spreadsheet with site numbers on tabs of spreadsheet using code from Bob Hirsh for Quantile Kendall plots based on climate year and to save output as a .RDS file


Gage Basin Characteristics LULC
Script creates a column combining NLCD LULC to determine percent coverage of LULC with calculation of NAWQA LULC based on percent coverage.

Kirk Quantile Kendall
Scripts loops to create pdf containing Quantile Kendall plots, output results, and export to Excel spreadsheet with site numbers on tabs of spreadsheet using code from Bob Hirsh for Quantile Kendall plots based on climate year and to save output as a .RDS file.

Mann-Kendall Trend Function
Final function used to run Mann-Kendall Trend Analysis.

Quantile Data Preparation
Script filters Quantile dataframe by wyear for decadal quantile dataframes, creates Quantile dataframes from Quantile_Final, change column names in Q00-Q100 dataframes, adds month, day, column for group for Quantile, renames columns in Quantile dataframes, and combines WY, day, and month into a Date column for timeseries (Have to change the column header to make work). In addition, it formats Date as.Date for Quantile dataframe.

Results Output Excel
Script saves result output as Excel file.

Tibble to Dataframe
Script converts a tibble to a dataframe for analysis.

This software is preliminary or provisional and is subject to revision. It is being provided to meet the need for timely best science. The software has not received final approval by the U.S. Geological Survey (USGS). No warranty, expressed or implied, is made by the USGS or the U.S. Government as to the functionality of the software and related material nor shall the fact of release constitute any such warranty. The software is provided on the condition that neither the USGS nor the U.S. Government shall be held liable for any damages resulting from the authorized or unauthorized use of the software.

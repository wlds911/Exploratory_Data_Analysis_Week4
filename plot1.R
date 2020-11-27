

################################################################################
# Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.
################################################################################

# Reading the two files using readRDS() function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# The attach() function in R can be used to make objects within
# dataframes accessible in R with fewer keystrokes. It is usually
# used with larger data sets.

attach(NEI)
dat <- tapply((Emissions)/1000, year, sum)

# Initiating the plot
png('plot1.png')

# Filling the plot 
barplot(dat, main = "PM2.5 emissions data for 1999, 2002, 2005, and 2008",
                     xlab = 'Year', ylab = 'PM2.5 Emissions',
                     col = c('blue','green', 'red', 'orange'))
dev.off()

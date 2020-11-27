
################################################################################
# Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.
################################################################################

# Reading the two files using readRDS() function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting the Baltimore City (Maryland) Data
MD <- subset(NEI, fips=='24510')

# Initiating the plot 
png(filename='plot2.png')

# Filling the plot
barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum),
                 main='Total Emission in Baltimore City, MD', xlab='Year',
                 ylab=expression('PM'[2.5]),
                 col = c('blue','green', 'red', 'orange'))
dev.off()

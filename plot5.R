
################################################################################
# Question 5
# How have emissions from motor vehicle sources changed from 1999–2008
# in Baltimore City?
################################################################################

# Reading the two files using readRDS() function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Subsetting the emissions data from motor vehicles in Baltimore City, MD
MD.vehicles <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

MD.dat <- aggregate(MD.vehicles[, 'Emissions'], by=list(MD.vehicles$year), sum)
colnames(MD.dat) <- c('year', 'Emissions')

# Initiating the plot
png('plot5.png')

# Filling the plot
ggplot(MD.dat, aes(year, Emissions)) +
    geom_bar(aes(fill=year),stat = "identity") +
    ggtitle('Total emissions from motor vehicle in Baltimore City (1999 - 2008)') +
    xlab('Year') +
    ylab('Kilotons emission PM2.5') +
    geom_text(aes(label=round(Emissions), size=5, hjust=1, vjust=0))

dev.off()

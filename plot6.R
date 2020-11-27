
################################################################################
# Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽").
# Which city has seen greater changes over time in motor vehicle emissions?
################################################################################

# Reading the two files using readRDS() function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Subsetting the emissions data from motor vehicles in Baltimore City, MD
MD.vehicles <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

# Subsetting the emissions data from motor vehicles in Los Angeles County, CA
CA.vehicles <- subset(NEI, fips == '06037' & type == 'ON-ROAD')


MD.dat2 <- aggregate(MD.vehicles[, 'Emissions'], by=list(MD.vehicles$year), sum)
colnames(MD.dat2) <- c('year', 'Emissions')
MD.dat2$City <- paste(rep('MD', 4))

CA.dat <- aggregate(CA.vehicles[, 'Emissions'], by=list(CA.vehicles$year), sum)
colnames(CA.dat) <- c('year', 'Emissions')
CA.dat$City <- paste(rep('CA', 4))

comb.dat <- as.data.frame(rbind(MD.dat2, CA.dat))

# Initiating the plot
png('plot6.png')

# Filling the plot
ggplot(data=comb.dat, aes(year, Emissions)) + geom_bar(aes(fill=year),
                stat = "identity") + facet_grid(. ~ City) +
                ggtitle('Total Emissions from motor vehicles in Los Angeles vs. in Baltimore City') +
                ylab( 'Emission PM2.5') + xlab('Year') +
                geom_text(aes(label=round(Emissions), size=2, hjust=0.5, vjust=-0.55))

dev.off()


################################################################################
# Question 4
# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?
################################################################################

# Reading the two files using readRDS() function

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal related SCC
SCC.coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

dat2 <- merge(x=NEI, y=SCC.coal, by='SCC')
dat2.sum <- aggregate(dat2[, 'Emissions'], by=list(dat2$year), sum)
colnames(dat2.sum) <- c('Year', 'Emissions')

library(ggplot2)

# Initiating the plot
png(filename='plot4.png')

# Filling the plot
ggplot(data=dat2.sum, aes(x=Year, y=Emissions/1000)) +
    geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) +
    ggtitle(expression('Total Emissions of PM'[2.5])) +
    ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) +
    geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) +
    theme(legend.position='none') + scale_colour_gradient(low='blue', high='red')

dev.off()

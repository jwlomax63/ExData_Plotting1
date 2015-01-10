# Contruct Plot 1 : Frequency of Global Active Power values in a 2-day range

powerConsumptionFilename <-'household_power_consumption.txt'

# 2-day date range of interest
startDate   <- as.Date('2007-02-01')
endDate     <- as.Date('2007-02-02')

# Ingest data taking note of semicolon delimiter and NA's represented as ?'s; subset to the date range
df <- read.csv(powerConsumptionFilename, sep=';', na.strings='?')
dfDateRestricted <- df[as.Date(df$Date, "%d/%m/%Y") >= startDate & as.Date(df$Date, "%d/%m/%Y")<= endDate,]

# Open PNG device for output. Deafult hight and width are 480px, per instructions, so no need to declare
# Draw the frequency histogram, making some slight changes in axis labels and ticks

png(file='Plot1.png')
hist(dfDateRestricted$Global_active_power, col=c('red'), main="Global Active Power", xlab='Global Active Power (kilowatts)', yaxt='n')
axis(side=2, at=seq(0,1200,200), labels=seq(0,1200,200))

# Close the PNG device
dev.off()

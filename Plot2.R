# Contruct Plot 2 : Global Active Power values by minute within a 2-day range

powerConsumptionFilename <-'household_power_consumption.txt'

# 2-day date range of interest
startDate   <- as.Date('2007-02-01')
endDate     <- as.Date('2007-02-02')

# Ingest data taking note of semicolon delimiter and NA's represented as ?'s; subset to the date range
df <- read.csv(powerConsumptionFilename, sep=';', na.strings='?')
dfDateRestricted <- df[as.Date(df$Date, "%d/%m/%Y") >= startDate & as.Date(df$Date, "%d/%m/%Y")<= endDate,]

# Open PNG device for output. Deafult hight and width are 480px, per instructions, so no need to declare.

# Draw the plot but first ... 
#       (1) Transform the x axis into time points
#       (2) Choose a line type graph rather than discrete points
#       (3) Make some slight changes in axis labels.

png(file='Plot2.png')

plot(strptime(paste(dfDateRestricted[, c('Date')] , dfDateRestricted[,c('Time')]), format='%d/%m/%Y %H:%M:%S'), 
     dfDateRestricted$Global_active_power, 
     ylab='Global Active Power (kilowatts)', 
     type='l', 
     xlab='')

# Close the PNG device
dev.off()

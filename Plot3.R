# Contruct Plot 3 : The three sub metering values by minute within a 2-day range

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

png(file='Plot3.png')

plot(strptime(paste(dfDateRestricted[, c('Date')] , dfDateRestricted[,c('Time')]), format='%d/%m/%Y %H:%M:%S'), 
     dfDateRestricted$Sub_metering_1, 
     ylab='Energy Sub Metering', 
     type='l', 
     xlab='',
     col=c('black'))

# Add the sub metering 2 and 3 lines to the plot
lines(strptime(paste(dfDateRestricted[, c('Date')] , dfDateRestricted[,c('Time')]), format='%d/%m/%Y %H:%M:%S'), 
     dfDateRestricted$Sub_metering_2, 
     col=c('red'))

lines(strptime(paste(dfDateRestricted[, c('Date')] , dfDateRestricted[,c('Time')]), format='%d/%m/%Y %H:%M:%S'), 
      dfDateRestricted$Sub_metering_3, 
      col=c('blue'))

# Add the legend explaining the different lines
legend('topright', c('Sub Metering 1', 'Sub Metering 2', 'Sub Metering 3'), lty=c(1,1,1), lwd=c(2.5,2.5, 2.5),col=c("black","red", "blue")) 

# Close the PNG device
dev.off()

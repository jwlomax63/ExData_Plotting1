# Contruct Plot 4 : Plot four graphs in one

powerConsumptionFilename <-'household_power_consumption.txt'

# 2-day date range of interest
startDate   <- as.Date('2007-02-01')
endDate     <- as.Date('2007-02-02')

# Ingest data taking note of semicolon delimiter and NA's represented as ?'s; subset to the date range
df <- read.csv(powerConsumptionFilename, sep=';', na.strings='?')
dfDateRestricted <- df[as.Date(df$Date, "%d/%m/%Y") >= startDate & as.Date(df$Date, "%d/%m/%Y")<= endDate,]

# Open PNG device for output. Deafult hight and width are 480px, per instructions, so no need to declare

# Draw the plots but first ... 
#       (1) Use par() to compose a 2x2 area for the 4 plots [UL clockwise fill]
#       (2) Transform the x axis into time points
#       (3) Choose a line type graph rather than discrete points
#       (4) Make some slight changes in axis labels.

png(file='Plot4.png')
par (mfrow=c(2,2))

#-------------------------------------------------#
#   Global Active Power by Minute (upper left)    #
#-------------------------------------------------#
plot(strptime(paste(dfDateRestricted[, c('Date')] , dfDateRestricted[,c('Time')]), format='%d/%m/%Y %H:%M:%S'), 
     dfDateRestricted$Global_active_power, 
     ylab='Global Active Power', 
     type='l', 
     xlab='')

#-------------------------------------------------#
#   Voltage by Minute (upper right)               #
#-------------------------------------------------#
plot(strptime(paste(dfDateRestricted[, c('Date')] , dfDateRestricted[,c('Time')]), format='%d/%m/%Y %H:%M:%S'), 
     dfDateRestricted$Voltage, 
     ylab='Voltage', 
     type='l', 
     xlab='datetime')


#---------------------------------------------------------#
#   Energy Sub Metering (1,2,3) by Minute (lower left)    #
#---------------------------------------------------------#
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


#---------------------------------------------------#
#   Global Reactive Power by Minute (lower right)   #
#---------------------------------------------------#
plot(strptime(paste(dfDateRestricted[, c('Date')] , dfDateRestricted[,c('Time')]), format='%d/%m/%Y %H:%M:%S'), 
     dfDateRestricted$Global_reactive_power, 
     ylab='Global Reactive Power', 
     type='l', 
     xlab='datetime')

# Close the PNG device
dev.off()

# read large file using fread for speed, only 4000 rows which captures 1-2 Feb 2007
# first get the headers of the file and then a relevant subset
    HD <- fread("household_power_consumption.txt", sep=";", na.strings="?", nrows=1)
    DTBL <- fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", skip="1/2/2007", nrows=3000)

# set master data var names
    setnames(DTBL,names(HD))

#subset to create our final table and eliminate extra records
    FSET <- subset(DTBL,DTBL$Date!="3/2/2007")

# handle date and times
#convert to POSIXDT
    datim <- strptime(paste(FSET$Date,FSET$Time), "%d/%m/%Y %H:%M:%S")

# open graphics device
    png(filename="./plot4.png")
    
# set our 2 by 2 space for our 4 charts
    par(mfrow=c(2,2))
    
# first graph is just like plot2.R
    plot(datim,FSET$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
# second is new    
    plot(datim,FSET$Voltage, type="l", xlab="datetime", ylab="Voltage")
# third is like plot3.R with a slight change in the legend, no border
    plot(datim, FSET$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(datim, FSET$Sub_metering_1, col="black")
    lines(datim, FSET$Sub_metering_2, col="red")
    lines(datim, FSET$Sub_metering_3, col="blue")
    legend("topright", lty=c(1,1), col = c("black", "red", "blue"), bty="n",  
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# last one is a new one similar to 2 above 
    plot(datim,FSET$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
#close device
    dev.off()
    
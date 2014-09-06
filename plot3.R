# read large file using fread for speed, only 4000 rows which captures 1-2 Feb 2007

# first get the headers of the file and then a relevant subset
  library("data.table")
  HD <- fread("household_power_consumption.txt", sep=";", na.strings="?", nrows=1)
  DTBL <- fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", skip="1/2/2007", nrows=3000)

# set master data var names
  setnames(DTBL,names(HD))

#subset to create our final table
  FSET <- subset(DTBL,DTBL$Date!="3/2/2007")

# handle date and times
# convert to POSIXDT
  datetime <- strptime(paste(FSET$Date,FSET$Time), "%d/%m/%Y %H:%M:%S")
    
# open graphics device
  png(filename="./plot3.png")
  
# create plot and save to PNG
  plot(datetime, FSET$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  lines(datetime, FSET$Sub_metering_1, col="black")
  lines(datetime, FSET$Sub_metering_2, col="red")
  lines(datetime, FSET$Sub_metering_3, col="blue")
  legend("topright", lty=c(1,1), col = c("black", "red", "blue"),  
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # close device
    dev.off()  
  
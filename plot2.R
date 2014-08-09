# read large file using fread for speed, only 4000 rows which captures 1-2 Feb 2007

# first get the headers of the file and then a relevant subset
  HD <- fread("household_power_consumption.txt", sep=";", na.strings="?", nrows=1)
  DTBL <- fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", skip="1/2/2007", nrows=3000)

# set master data var names
  setnames(DTBL,names(HD))

#subset to create our final table
  FSET <- subset(DTBL,DTBL$Date!="3/2/2007")

# handle date and times
  #convert to POSIXDT
  datim <- strptime(paste(FSET$Date,FSET$Time), "%d/%m/%Y %H:%M:%S")
  
# open graphics device
  png(filename="./plot2.png")
  
# create plot and save to PNG
  plot(datim,FSET$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
# close device
  dev.off()
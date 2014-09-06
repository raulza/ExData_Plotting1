# read large file using fread for speed, only 4000 rows which captures 1-2 Feb 2007
  
# first get the headers of the file and then a relevant subset
  library("data.table")
  HD <- fread("household_power_consumption.txt", sep=";", na.strings="?", nrows=1)
  DTBL <- fread("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", skip="1/2/2007", nrows=3000)

  # set master data var names
  setnames(DTBL,names(HD))
  
  #subset to create our final table
  FSET <- subset(DTBL,DTBL$Date!="3/2/2007")
  
  # open graphics device
  png(filename="./plot1.png")
  
  #create plot with annotations
  hist(FSET$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts")
  
  # close device
  dev.off()
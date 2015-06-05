library("sqldf")
##using sqldf library read in only rows for the correct dates
hpc <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")
closeAllConnections()  #cleanup file connections
#
#create combined date and Time column
datetime <- paste(hpc$Date, hpc$Time)
hpc$datetime <- as.POSIXlt(datetime, format="%d/%m/%Y %H:%M:%S") #format column as correct class and add
#
png("./plot2.png",width=480,height=480)  #open png format with correct name and size
plot(hpc$datetime, hpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()  #close device
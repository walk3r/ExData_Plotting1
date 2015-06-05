library("sqldf")
##using sqldf library read in only rows for the correct dates
hpc <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")
closeAllConnections()  #cleanup file connections
#
png("./plot1.png",width=480,height=480)  #open png format with correct name and size
hist(hpc$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()  #close device
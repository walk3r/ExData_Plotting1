library("sqldf")
##using sqldf library read in only rows for the correct dates
hpc <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")
closeAllConnections()  #cleanup file connections
#
#create combined date and Time column
datetime <- paste(hpc$Date, hpc$Time)
hpc$datetime <- as.POSIXlt(datetime, format="%d/%m/%Y %H:%M:%S") #format column as correct class and add
#
png("./plot4.png",width=480,height=480)  #open png format with correct name and size
# create 2 x 2 plot area
par(mfrow = c(2,2))
#build first plot
plot(hpc$datetime, hpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#build 2nd plot
plot(hpc$datetime, hpc$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#build 3rd plot
with(hpc, plot(datetime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = " "))
with(hpc, lines(datetime, Sub_metering_1, col = "black"))
with(hpc, lines(datetime, Sub_metering_2, col = "red"))
with(hpc, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#build 4th plot
plot(hpc$datetime, hpc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()  #close device
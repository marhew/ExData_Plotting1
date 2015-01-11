colNames <- read.csv("household_power_consumption.txt", 
                     sep=";", nrows=1)
powerUse <- read.csv("household_power_consumption.txt", 
                     sep=";", skip=46*24*60, nrows=3*24*60,
                     col.names = names(colNames), 
                     colClasses=c("character","character",rep("numeric",7)))
powerUse$timestamp <- strptime(paste(powerUse$Date, powerUse$Time), 
                               format = "%d/%m/%Y %H:%M:%S")
powerUse2Days <- powerUse[powerUse$Date %in% c("1/2/2007","2/2/2007"),]
png(filename = "plot4.png", width=480, height=480, bg="white")
par(mfrow = c(2,2))
with(powerUse2Days, {
  plot(timestamp, Global_active_power, type = "l",
       ylab = "Global Active Power", xlab ="")
  plot(timestamp, Voltage, type = "l",
       ylab = "Voltage", xlab ="datetime")
  plot(timestamp, Sub_metering_1, type = "l",
       ylab = "Energy sub metering", xlab ="")
  points(timestamp, Sub_metering_2, col = "red", type = "l")
  points(timestamp, Sub_metering_3, col = "blue", type = "l")
  legend("topright", lty=1, col = c("black", "red", "blue"), 
         legend = names(colNames)[7:9])
  plot(timestamp, Global_reactive_power, type = "l", xlab ="datetime")
})
dev.off()
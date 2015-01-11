# read only one row to get column names
colNames <- read.csv("household_power_consumption.txt", sep=";", nrows=1)
powerUse <- read.csv("household_power_consumption.txt", sep=";", 
                     skip=46*24*60, # skip the first 46 days
                     nrows=3*24*60, # read in only 3 days to save RAM
                     col.names = names(colNames), # use previously read column names
                     # read Date, Time as character, other columns as numeric
                     colClasses=c("character","character",rep("numeric",7)))

# filter, data only for days 1/2/2007 and 2/2/2007
powerUse2Days <- powerUse[powerUse$Date %in% c("1/2/2007","2/2/2007"),]
# add new column 'timestamp' with POSIXct object
powerUse2Days$timestamp <- strptime(paste(powerUse2Days$Date, 
                                          powerUse2Days$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

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
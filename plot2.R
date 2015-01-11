colNames <- read.csv("household_power_consumption.txt", 
                     sep=";", nrows=1)
powerUse <- read.csv("household_power_consumption.txt", 
                     sep=";", skip=46*24*60, nrows=3*24*60,
                     col.names = names(colNames), 
                     colClasses=c("character","character",rep("numeric",7)))
powerUse$timestamp <- strptime(paste(powerUse$Date, powerUse$Time), 
                               format = "%d/%m/%Y %H:%M:%S")
powerUse2Days <- powerUse[powerUse$Date %in% c("1/2/2007","2/2/2007"),]

plot(powerUse2Days$timestamp,
     powerUse2Days$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab ="")

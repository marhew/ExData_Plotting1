colNames <- read.csv("household_power_consumption.txt", 
                     sep=";", nrows=1)
powerUse <- read.csv("household_power_consumption.txt", 
                     sep=";", skip=46*24*60, nrows=3*24*60,
                     col.names = names(colNames), 
                     colClasses=c("character","character",rep("numeric",7)))
powerUse2Days <- powerUse[powerUse$Date %in% c("1/2/2007","2/2/2007"),]
png(filename = "plot1.png", width=480, height=480, bg="white")
hist(powerUse2Days$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red", breaks=15)
dev.off()
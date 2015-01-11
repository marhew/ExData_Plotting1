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

png(filename = "plot1.png", width=480, height=480, bg="white")
hist(powerUse2Days$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red", breaks=15)
dev.off()
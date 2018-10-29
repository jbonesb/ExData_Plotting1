# This script plot graphs to "plot4.png" in current WD
# from Individual household electric power consumption Data Set

# Current WD must contains "household_power_consumption.txt" file
# On the plot Week days prints in russian, because russian locale installed on my computer 

# I use sqldf package to load data with condition, so the first step is to check
# is the package exist and install it if not.
if(!"sqldf" %in% rownames(installed.packages())) install.packages("sqldf")
library(sqldf)

# read data, filtered with two asked dates 
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", 
                     eol = "\n", header = T, sep = ";", stringsAsFactors =F)

data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y%T")
data$Date <- as.Date(data$Date,"%d/%m/%Y")

# plot grapf directly to png file in current WD with asked resolution
# because the legend has been cuted when I was try to copy screen plot  

png("plot4.png", width = 480, height = 480)

# config plots structure
par(mfcol=c(2,2))

# first plot with Global Active Power (kilowatts)
with(data, plot(Time, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))

# second with Energy sub metering
with(data, plot(Time, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l"))
with(data, lines(Time, Sub_metering_2, col="red", type = "l"))
with(data, lines(Time, Sub_metering_3, col="blue", type = "l"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         col=c("black","red","blue"), lwd = 1, bty = "n")

# third with Voltage
with(data, plot(Time, Voltage, xlab = "datetime", type = "l"))

# fourth with Reactive Power
with(data, plot(Time, Global_reactive_power, xlab = "datetime", type = "l"))

dev.off()

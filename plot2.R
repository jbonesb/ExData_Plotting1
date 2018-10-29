# This script plot graphs to "plot2.png" in current WD
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

# plot grapf and copy it to the file in current WD with asked resolution
with(data, plot(Time, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

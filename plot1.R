# This script plot graphs to "plot1.png" in current WD
# from Individual household electric power consumption Data Set

# Current WD must contains "household_power_consumption.txt" file
# On the plot Week days prints in russian, because russian locale installed on my computer 

# I use sqldf package to load data with condition, so the first step is to check
# is the package exist and install it if not.
if(!"sqldf" %in% rownames(installed.packages())) install.packages("sqldf")
library(sqldf)

# read data, filtered with two asked dates 
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = "select * from file where Date in ('1/2/2007','2/2/2007')", eol = "\n", 
                     header = T, sep = ";", stringsAsFactors =F)

# plot histogramme and copy it to the file in current WD with asked resolution
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

# dataset is already downloaded in ./data folder, unzip downloaded file
unzip("./data/exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = "./data/")

# estimate memory of the dataset: 2,075,259 * 9 * 8 bytes/numeric / 2^20 bytes/MB
# memory_estimate <- 2075259 * 9 * 8 / 2^20 # memory_estimate = 142.5 MB 

# read data
library(data.table)
dataset <- fread("./data/household_power_consumption.txt", na.strings = "?")

# define date format 
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

# subset data to use data only from the dates 2007-02-01 and 2007-02-02
subdata <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

# combine first 2 columns of subset data
library(tidyr)
subdata <- unite(subdata,Date,Time, sep = " ", col = "DateTime", remove = TRUE)
subdata$DateTime <- as.POSIXct(subdata$DateTime)

# plot 2
png(file = "plot2.png", height = 480, width = 480)
with(subdata, plot(Global_active_power ~ DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
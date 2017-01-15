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

# plot 3
png(file = "plot3.png", height = 480, width = 480)
plot(subdata$Sub_metering_1 ~ subdata$DateTime, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
par(new = T)
plot(subdata$Sub_metering_2 ~ subdata$DateTime, type = "l", xlab = "", ylab = "", col = "red", ylim = c(0,max(subdata$Sub_metering_1)))
par(new = T)
plot(subdata$Sub_metering_3 ~ subdata$DateTime, type = "l", xlab = "", ylab = "", col = "blue", ylim = c(0,max(subdata$Sub_metering_1)))
legend("topright",lwd = c(1,1,1), col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
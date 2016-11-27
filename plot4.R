library(dplyr)
library(lubridate)

# Download archive and unzip it
setwd("~/data")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "power.zip")
unzip("power.zip")

# Import data, cast Date-Time to appropriate format and keep only required days
pw <- read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F, na.strings = "?")
pw$Date <- as.POSIXct(strptime(with(pw, paste(Date, Time)), format = "%d/%m/%Y %T"))
data <- filter(pw, date(Date) == "2007-02-01" | date(Date) == "2007-02-02" )


# Plot 4
png("plot4.png", width = 480, height = 480)
# set layout
par(mfrow = c(2,2))
# 1st of 4 graphs
with(data, plot(Date, Global_active_power, type = "n", ylab="Global Active Power", xlab=""))
with(data, lines(Date, Global_active_power))
# 2nd of 4 graphs
with(data, plot(Date, Voltage, type = "n", ylab="Voltage", xlab="datetime"))
with(data, lines(Date, Voltage))
# 3rd of 4 graphs
with(data, plot(x = Date, y= Sub_metering_1, type = "n", ylab="Energy Sub Metering", xlab=""))
with(data, lines(x = Date, y= Sub_metering_1, col="black"))
with(data, lines(x = Date, y= Sub_metering_2, col="red"))
with(data, lines(x = Date, y= Sub_metering_3, col="blue"))
legend(x="topright", lty=c(1,1,1), bty="n", col= c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# 4th of 4 graphs
with(data, plot(Date, Global_reactive_power, type = "n", xlab="datetime"))
with(data, lines(Date, Global_reactive_power))
dev.off()
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

# Plot 2
png("plot2.png", width = 480, height = 480)
with(data, plot(Date, Global_active_power, type = "n", ylab="Global Active Power (Kilowatts)", xlab=""))
with(data, lines(Date, Global_active_power))
dev.off()
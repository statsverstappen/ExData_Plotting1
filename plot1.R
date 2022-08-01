##exploratory data analysis
##week 1 project
install.packages("tidyverse")
install.packages("lubridate")
library(lubridate)
library(tidyverse)

##download UCI dataset
file.url_1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile_1 <-  paste(getwd(), "power", sep = "")       

if(!file.exists(destfile_1)) {
        
        download.file(file.url_1, destfile = destfile_1, mode = "wb")
}

##unizpping file
dtpath <- "power"

if(!file.exists(dtpath)) {
        unzip(destfile_1)
}

##reading data into dataframe
power <- read.csv("household_power_consumption.txt", sep = ";")
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Global_intensity <- as.numeric(power$Global_intensity)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)

##creating date/time variable
power <- mutate(power, datetime = paste(Date, Time))

##converting date/time into POSIXct
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)
power$datetime <- dmy_hms(power$datetime)

##keep dates from 2007-02-01 , 2007-02-02****
power_feb <- filter(power, 
                    Date == "2007-02-01" | Date == "2007-02-02")

##generating and checking plot1
with(power_feb,
     hist(Global_active_power, 
          col = "red",
          xlab = "Global Active Power (kilowatts)",
          main = "Global Active Power"))


##saving plot1 as png
png(filename = "plot1.png", width = 480, height = 480)

with(power_feb,
     hist(Global_active_power, 
          col = "red",
          xlab = "Global Active Power (kilowatts)",
          main = "Global Active Power"))
dev.off()
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

##converting date, time, date/time into POSIXct
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)
power$datetime <- dmy_hms(power$datetime)

##keep dates from 2007-02-01 , 2007-02-02
power_feb <- filter(power, 
                    Date == "01/02/2007" | Date == "02/02/2007")

##generating and checking plot3
with(power_feb,
     plot(datetime, Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering",
          col = "black"))

with(power_feb,
        lines(datetime, Sub_metering_2,
              col = "red"))

with(power_feb,
     lines(datetime, Sub_metering_3,
           col = "blue"))

legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ),
       lty = 1, 
       col = c("black", "red", "blue"))


###saving plot3 as png
png(filename = "plot3.png", width = 480, height = 480)

with(power_feb,
     plot(datetime, Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering",
          col = "black"))

with(power_feb,
     lines(datetime, Sub_metering_2,
           col = "red"))

with(power_feb,
     lines(datetime, Sub_metering_3,
           col = "blue"))

legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ),
       lty = 1, 
       col = c("black", "red", "blue"))

dev.off()
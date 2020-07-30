

## library

library(data.table)
library(dplyr)
library(lubridate)

####download file:


setwd("G:\\Scripting\\R\\John Hopkins Data Science\\Exploratory Data Analysis\\week 1 assignment")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

path<- getwd()

download.file(url,file.path(path, "dataFiles.zip"))

unzip(zipfile ="dataFiles.zip")

df <- fread(input = "household_power_consumption.txt", na.strings="?") # create df and set ? as NULL value

# retain only relevant part of the df



df[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]  # merge date and time

df <- df[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")] # only relevant dates



#### plot1


png("plot1.png", width=480, height=480)

hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()


##### plot 2





png("plot2.png", width=480, height=480)


plot(x = df$dateTime, y = df$Global_active_power
     , type="l",
     xlab=""
     , ylab="Global Active Power (kilowatts)")

dev.off()

###plot 3



png("plot3.png", width=480, height=480)


plot(df$dateTime, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df$dateTime, df$Sub_metering_2,col="red")
lines(df[, dateTime], df$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()




###plots 4-7


png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(df$dateTime, df$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(df$dateTime,df$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(df$dateTime, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df$dateTime, df$Sub_metering_2, col="red")
lines(df$dateTime, df$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1) , bty="n" , cex=.5) 

# Plot 4
plot(df$dateTime, df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()






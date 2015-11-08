sample_text <- read.csv2("household_power_consumption.txt", na.strings = "?")
sample_text$Date <- as.Date(sample_text$Date, "%d/%m/%Y")
desired_date_range <- sample_text[sample_text$Date == "2007-02-01" | sample_text$Date == "2007-02-02" ,]
sample_text <- NULL
rm(list = "sample_text")
desired_date_range <- within(desired_date_range, { timestamp=format(as.POSIXct(paste(Date, Time)), "%m/%d/%Y %H:%M:%S") })
desired_date_range$Global_active_power <- as.numeric(desired_date_range$Global_active_power)
png("Plot4.png")
par(mfrow=c(2,2))
hist(desired_date_range$Global_active_power, xaxt = 'n', col = "red",
     main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
axis(side = 1, at = seq(0, 3000, 1000), labels = seq(0, 6, 2))
plot(as.POSIXct(desired_date_range$timestamp, format= "%m/%d/%Y %H:%M:%S"), desired_date_range$Voltage,
     main = "", type = "l", xlab = "datetime", ylab = "Voltage",
     xlim = c(as.POSIXct(desired_date_range$timestamp[1], format = "%m/%d/%Y %H:%M:%S"),
              as.POSIXct(desired_date_range$timestamp[length(desired_date_range$Date)], format="%m/%d/%Y %H:%M:%S")))
plot(as.POSIXct(desired_date_range$timestamp, format= "%m/%d/%Y %H:%M:%S"), desired_date_range$Sub_metering_1,
     main = "", type = "l", ylab = "Energy sub metering", yaxt = 'n', xlab = "",
     xlim = c(as.POSIXct(desired_date_range$timestamp[1], format = "%m/%d/%Y %H:%M:%S"),
              as.POSIXct(desired_date_range$timestamp[length(desired_date_range$Date)], format="%m/%d/%Y %H:%M:%S")))
par(new = TRUE)
lines(as.POSIXct(desired_date_range$timestamp, format= "%m/%d/%Y %H:%M:%S"), desired_date_range$Sub_metering_2,
      col = "red")
lines(as.POSIXct(desired_date_range$timestamp, format= "%m/%d/%Y %H:%M:%S"), desired_date_range$Sub_metering_3,
      col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=1:3, lty = 1) 
axis(side = 2, at = seq(0, 30, 10), labels = seq(0, 30, 10))
plot(as.POSIXct(desired_date_range$timestamp, format= "%m/%d/%Y %H:%M:%S"), desired_date_range$Global_reactive_power,
     main = "", yaxt = 'n', type = "l", ylab = "Global_reactive_power", xlab = "datetime",
     xlim = c(as.POSIXct(desired_date_range$timestamp[1], format = "%m/%d/%Y %H:%M:%S"),
              as.POSIXct(desired_date_range$timestamp[length(desired_date_range$Date)], format="%m/%d/%Y %H:%M:%S")))
axis(side = 2, at = seq(0, 200, 40), labels = seq(0, 0.5, 0.1))
dev.off()

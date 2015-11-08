sample_text <- read.csv2("household_power_consumption.txt", na.strings = "?")
sample_text$Date <- as.Date(sample_text$Date, "%d/%m/%Y")
desired_date_range <- sample_text[sample_text$Date == "2007-02-01" | sample_text$Date == "2007-02-02" ,]
sample_text <- NULL
rm(list = "sample_text")
desired_date_range <- within(desired_date_range, { timestamp=format(as.POSIXct(paste(Date, Time)), "%m/%d/%Y %H:%M:%S") })
png("Plot2.png")
plot(as.POSIXct(desired_date_range$timestamp, format= "%m/%d/%Y %H:%M:%S"), desired_date_range$Global_active_power,
     main = "", yaxt = 'n', type = "l", ylab = "Global Active Power (Kilowatts)", xlab = "",
     xlim = c(as.POSIXct(desired_date_range$timestamp[1], format = "%m/%d/%Y %H:%M:%S"),
              as.POSIXct(desired_date_range$timestamp[length(desired_date_range$Date)], format="%m/%d/%Y %H:%M:%S")))
axis(side = 2, at = seq(0, 3000, 1000), labels = seq(0, 6, 2))
dev.off()

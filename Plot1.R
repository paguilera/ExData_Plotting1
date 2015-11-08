sample_text <- read.csv2("household_power_consumption.txt", na.strings = "?")
sample_text$Date <- as.Date(sample_text$Date, "%d/%m/%Y")
desired_date_range <- sample_text[sample_text$Date == "2007-02-01" | sample_text$Date == "2007-02-02" ,]
sample_text <- NULL
rm(list = "sample_text")
desired_date_range$Global_active_power <- as.numeric(desired_date_range$Global_active_power)
png("Plot1.png")
hist(desired_date_range$Global_active_power, xaxt = 'n', col = "red",
     main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
axis(side = 1, at = seq(0, 3000, 1000), labels = seq(0, 6, 2))
dev.off()

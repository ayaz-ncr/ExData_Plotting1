# find rows for specified date, earlier rows to be skipped
skip<-grep("\\b1/2/2007\\b", readLines("household_power_consumption.txt"))

# find rows for specified date 
rows<-grep('\\b2/2/2007\\b', readLines("household_power_consumption.txt"))

# read only rows related to 2 dates in data table
n<-length(skip)+length(rows)

DT1<-read.table("household_power_consumption.txt", sep=";", header = TRUE, skip = skip[1]-1
                , nrows = n, colClasses = c("character", "character", "numeric", "numeric"
                                            , "numeric", "numeric", "numeric", "numeric", "numeric"))

colnames(DT1)<-c("date", "time", "global_active_power", "global_reactive_power", "voltage"
                 , "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

DT1$datetime<-strptime(paste(DT1$date, DT1$time), "%d/%m/%Y %H:%M:%S")

# plot 4
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# plot 4.1
plot(DT1$datetime, DT1$global_active_power, type="l", xlab= "", ylab = "Global Active Power (kilowatts)")

# plot 4.2
plot(DT1$datetime, DT1$voltage, type="l", xlab= "datetime", ylab = "Voltage")

# plot 4.3
plot(DT1$datetime, DT1$sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(DT1$datetime, DT1$sub_metering_2, col="red")
lines(DT1$datetime, DT1$sub_metering_3, col="blue")
legend("topright", legend = colnames(DT1[1,7:9]), bty="n", col = c("black", "red", "blue"), lty = 1, cex=0.50)

# plot 4.4
plot(DT1$datetime, DT1$global_reactive_power, type="l", xlab= "datetime", ylab = "Global_Active_Power")

dev.off()
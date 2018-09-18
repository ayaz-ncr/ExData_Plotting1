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

# plot 3
png("plot3.png", width=480, height=480)
plot(DT1$datetime, DT1$sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(DT1$datetime, DT1$sub_metering_2, col="red")
lines(DT1$datetime, DT1$sub_metering_3, col="blue")
legend("topright", legend = colnames(DT1[1,7:9]), col = c("black", "red", "blue"), lty = 1, cex=0.75)
dev.off()
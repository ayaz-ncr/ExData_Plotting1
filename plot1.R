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

# plot 1

# save plot as png file
png("plot1.png", width=480, height=480)
hist(DT1$global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
#dev.copy(png, file="plot1.png")
dev.off()


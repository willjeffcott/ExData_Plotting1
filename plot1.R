#### read in the .txt data file
power <- read.table('household_power_consumption.txt',header=TRUE, sep=";")

#restrict to the correct dates, then reformat the Date and Time columns
power_dates <- subset(power,as.character(Date)=="1/2/2007" | as.character(Date)=="2/2/2007")

library(lubridate)
#create a single date-time variable
power_dates$Date_Time = dmy_hms(paste(power_dates$Date,power_dates$Time,sep=" "))

#Convert vars which need to be numeric to numeric
for (i in 3:9){
  power_dates[,i] = as.numeric(as.character(power_dates[,i]))
}


#### create the first plot in the R graphics device
windows()

#histogram, with title 'Global Active Power', x-axis label, and red bars
hist(power_dates$Global_active_power,
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)',
     col = 'red')

#now convert to png
dev.copy(png,file='plot1.png',width=480,height=480)
dev.off()
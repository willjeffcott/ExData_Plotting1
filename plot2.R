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


#### create the second plot in the R graphics device
windows()

#plot Global Active Power (y) and Date_Time (x)
with(power_dates,plot(x=Date_Time,
                      y=Global_active_power,
                      type="n",
                      xlab="",
                      ylab="Global Active Power (kilowatts)"))
with(power_dates,lines(Date_Time,Global_active_power))


#now convert to png
dev.copy(png,file='plot2.png',width=480,height=480)
dev.off()
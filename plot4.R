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


#### create the fourth plot in the R graphics device

#set up a 2x2 grid, to be populated row-wise
windows()
par(mfrow=c(2,2))

#plot Global Active Power (y) and Date_Time (x) - top left
with(power_dates,plot(x=Date_Time,
                      y=Global_active_power,
                      type="n",
                      xlab="",
                      ylab="Global Active Power (kilowatts)"))
with(power_dates,lines(Date_Time,Global_active_power))

#plot Voltage (y) and Date_Time (x) - top right
with(power_dates,plot(x=Date_Time,
                      y=Voltage,
                      type="n",
                      xlab="datetime",
                      ylab="Voltage"))
with(power_dates,lines(Date_Time,Voltage))


#plot Energy sub metering (y) and Date_Time (x) - bottom left
with(power_dates,plot(x=Date_Time,
                      y=Sub_metering_1,
                      type="n",
                      xlab="",
                      ylab="Energy sub metering"))

#plot the 3 lines
with(power_dates,{
  lines(Date_Time,Sub_metering_1,col="black")
  lines(Date_Time,Sub_metering_2,col="red")
  lines(Date_Time,Sub_metering_3,col="blue")
})

#add in legend
legend("topright",
       lty=c(1,1,1),
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n")

#plot Global Reactive Power (y) and Date_Time (x) - bottom right
with(power_dates,plot(x=Date_Time,
                      y=Global_reactive_power,
                      type="n",
                      xlab="datetime",
                      ylab="Global_reactive_power"))
with(power_dates,lines(Date_Time,Global_reactive_power))

#now convert to png
dev.copy(png,file='plot4.png',width=480,height=480)
dev.off()
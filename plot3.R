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


#### create the third plot in the R graphics device
windows()

#blank plot to begin with so we can add lines later, 1 taken as it is the largest
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
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#now convert to png
dev.copy(png,file='plot3.png',width=480,height=480)
dev.off()
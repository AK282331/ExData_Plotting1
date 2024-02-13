## Load the required libraries for the plotting

library(dplyr)
library(tidyr)
library(data.table)
library(lubridate)

## Load the data into R

path = "C:\\Users\\Abhinav Khandelwal\\OneDrive\\Desktop\\R_project\\R_Learning_Coursera\\exdata_data_household_power_consumption\\household_power_consumption.txt"
Elect_data = fread(path,na.strings = "?",sep = ";")

## Converting Date and Time variable into Date/Time class and 
## store in new variable called Date_Time
## and removing Date and Time Variable 

Elect_data = Elect_data %>% 
        mutate(Date_Time = paste(Date,Time)) %>% 
        transform(Date_Time = dmy_hms(Date_Time)) %>% 
        select(-1,-2) %>%
        select(8,1:7)

## Extracting the data from the dates 2007-02-01 and 2007-02-02

Final_Elect_data = subset(Elect_data, format(Date_Time,format = "%Y-%m-%d") == "2007-02-01" |
                                  format(Date_Time,format = "%Y-%m-%d") == "2007-02-02" )

## Creating a column (Weekdays) to store weekdays in the Final_Elect_data 
## and store in the same Final_Elect_data object

Final_Elect_data = mutate(Final_Elect_data,Weekdays = wday(Date_Time))



## Creating a PNG file device with width 480 pixels and 480 pixels 

png(filename = "plot4.png",width = 480,height = 480)

## Setting frame to fit 2 x 2 plot and adjusting the margin

par(mfcol = c(2,2))
par(mar = c(4,4,2,3))

## Creating 1st plot

plot(Final_Elect_data$Date_Time,Final_Elect_data$Global_active_power,type = "l",xaxt = "n",ylab = "Global Active Power",xlab = "")
point1 = Final_Elect_data$Date_Time[1]
point2 = Final_Elect_data$Date_Time[1441]
point3 = Final_Elect_data$Date_Time[2880]
axis(side = 1, at = c(point1,point2,point3),labels = c("Thu","Fri","Sat"))


## Creating 2nd plot

plot(Final_Elect_data$Date_Time,Final_Elect_data$Sub_metering_1,col = "black",type = "l",xaxt = "n", xlab = " ", ylab = " ")
points(x = Final_Elect_data$Date_Time,y = Final_Elect_data$Sub_metering_2, col = "red",type = "l")
points(x = Final_Elect_data$Date_Time,y = Final_Elect_data$Sub_metering_3, col = "blue",type = "l")
title(ylab = "Energy sub metering")
axis(side = 1, at = c(point1,point2,point3),labels = c("Thu","Fri","Sat"))
legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty =1,seg.len = 0.5,x.intersp = 0.5)


## Creating 3rd Plot
plot(Final_Elect_data$Date_Time,Final_Elect_data$Voltage,type = "l",xaxt = "n",xlab = " ", ylab = " ")
title(xlab = "datetime",ylab = "Voltage")
axis(side = 1, at = c(point1,point2,point3),labels = c("Thu","Fri","Sat"))

## Creating 4th plot

plot(Final_Elect_data$Date_Time,Final_Elect_data$Global_reactive_power,type = "l",xaxt = "n", xlab = " ",ylab = " ")
title(xlab = "datetime",ylab = "Global_reactive_power")
axis(side = 1, at = c(point1,point2,point3),labels = c("Thu","Fri","Sat"))


## Closing the device
dev.off()



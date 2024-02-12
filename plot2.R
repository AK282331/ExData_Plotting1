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

png(filename = "plot2.png",width = 480,height = 480)

## Plotting line graph of "Global Active Power" over Date_Time

plot(Final_Elect_data$Date_Time,Final_Elect_data$Global_active_power,type = "l",xaxt = "n",ylab = "Global Active Power (kilowatts)",xlab = "")

## Extracting the points where i have to put the day ticks

point1 = Final_Elect_data$Date_Time[1]
point2 = Final_Elect_data$Date_Time[1441]
point3 = Final_Elect_data$Date_Time[2880]

## Putting (Thu, Fri, Sat) ticks on X-axis

axis(side = 1, at = c(point1,point2,point3),labels = c("Thu","Fri","Sat"))

## Closing the device

dev.off()






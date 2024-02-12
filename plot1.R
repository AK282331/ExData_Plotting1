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

## Creating a PNG file device with width 480 pixels and 480 pixels 

png(filename = "plot1.png",width = 480,height = 480)

## Plotting "Global Active Power" Graph 

hist(Final_Elect_data$Global_active_power,col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Closing the device

dev.off()




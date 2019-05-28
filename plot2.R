###Peer-graded Assignment: Course Project 1 for EDA Week 1 

setwd("C:/Users/ajohns34/Box/Data Science Specialization/Assignment 6")
##Install all packages needed in script:
        install.packages(c("ggplot2"))
        library(ggplot2)


#Checking for and creating directories
# file.exists("directoryname") - looks to see if the directory exists - T/F
# dir.create("directoryname") - creates a directory if it doesn't exist

#If the directory doesn't exist, make a new one:
        if(!file.exists("data")) {
                dir.create("data")
        }

##Give full path 
        list.files(full.names=TRUE)
##list files in the data directory
        list.files("data/", full.names=TRUE)
        
        house = read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?") 
        
        head(house)

#COnvert Date from factor to date
#Lubridate converts a number to a date or time, regardless of format
        class(house$Date)
        class(house$Time)
        
        install.packages("lubridate")
        library(lubridate)        
        #Converts text to dates, regardless of format
        
        house$Date = dmy(house$Date) 
        head(house)
        
        class(house$Time)
        ?lubridate
        
        house$datetime = as.POSIXct(paste(house$Date, house$Time), format = "%Y-%m-%d %H:%M:%S")
        head(house)
        class(house$datetime)

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
        subset_house = subset(house, ymd(Date)=="2007-02-01" | ymd(Date)=="2007-02-02")
        head(subset_house)

#Plot 2: Connected line chart that displays global active power over weekday (x-axis)
#We need to figure out the weekday associated with each date
        subset_house$weekday = weekdays(subset_house$Date)
        #We need to start with an empty plot, then add the lines so that the dots don't appear:
        #We also don't want a label on the x-axis
        #And we want a label on the y-axis
        #1. Open png device, create myplot in working directory        
        png("plot2.png", width=480, height=480)
        #2. Create plot
        plot(subset_house$datetime, subset_house$Global_active_power, 
             type="n", 
             xlab="", 
             ylab="Global Active Power (kilowatts)")
        lines(subset_house$datetime, subset_house$Global_active_power)
        #3. Copy plot to a png file
        dev.copy(png, file = "plot2.png")
        #4. Close pdf file device
        dev.off()
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

#Plot 3: Connected line chart that displays energy sub metering over weekday (x-axis)
        #Same with plot 2, start with an empty plot that only specifies formatting:
        #1. Open png device, create myplot in working directory        
        png("plot3.png", width=480, height=480)
        #2. Create plot
        plot(subset_house$datetime, subset_house$Sub_metering_1, 
             type="n", 
             xlab="", 
             ylab="Energy sub metering")
        lines(subset_house$datetime, subset_house$Sub_metering_1, col="black")
        lines(subset_house$datetime, subset_house$Sub_metering_2, col="red")
        lines(subset_house$datetime, subset_house$Sub_metering_3, col="blue")
        legend("topright", 
               lty=1, 
               col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        #3. Copy plot to a png file
        dev.copy(png, file = "plot3.png")
        #4. Close pdf file device
        dev.off()
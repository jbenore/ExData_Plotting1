## L O A D I N G   D A T A

## For this assignment, I'm not going to worry about reading in the partial data set.
## I'll assume that the user has enough memory to load the whole subset, and then I'll
## subset from there.
bigTable <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

## Convert Date to date class
bigTable$Date <- as.Date(bigTable$Date, format="%d/%m/%Y")

## Subset the table
powerTable <- bigTable[bigTable$Date > "2007-01-31" & bigTable$Date < "2007-02-03",]

## Needing to create a datetime variable ("Moment") combining Date and Time 
powerTable$Moment <- as.POSIXct(paste(powerTable$Date, powerTable$Time), format = "%Y-%m-%d %H:%M:%S")

## M A K I N G   P L O T S

## Opening the graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## setting up mfrow parameters for multiple plots
par(mfrow = c(2,2))

## Creating the first plot (see plot2.R for more info)
with(powerTable, plot(Moment, Global_active_power, 
                      type = "l", 
                      xlab = "", 
                      ylab = "Global Active Power (kilowatts)"))

## Creating the second plot
with(powerTable, plot(Moment, Voltage, 
                      type = "l", 
                      xlab = "datetime", 
                      ylab = "Voltage"))

## Creating the third plot (see plot3.R for more info)
with(powerTable, plot(Moment, Sub_metering_1, 
                      type = "l", 
                      xlab = "", 
                      ylab = "Energy sub metering"))
with(powerTable, lines(Moment, Sub_metering_2, 
                       type = "l", 
                       col = "red"))
with(powerTable, lines(Moment, Sub_metering_3, 
                       type = "l", 
                       col = "blue"))
legend(x = "topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1,
## NOTE: This legend differs from plot3 as it should not have a border
       bty = "n",
       col = c("black", "red", "blue"))

## Creating the fourth plot
with(powerTable, plot(Moment, Global_reactive_power, 
                      type = "l", 
                      xlab = "datetime", 
                      ylab = "Global_reactive_power"))

## Closing the graphics device
dev.off()


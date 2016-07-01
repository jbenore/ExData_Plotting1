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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

## Creating the plot
with(powerTable, plot(Moment, Global_active_power, 
                      type = "l", 
                      xlab = "", 
                      ylab = "Global Active Power (kilowatts)"))

## Closing the graphics device
dev.off()


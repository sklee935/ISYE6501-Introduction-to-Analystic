library(forecast)
library(lubridate)

# Loading the data
file_path <- "C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501 Introduction to Analystic/HW4/temps.txt"
temps <- read.table(file_path, header = TRUE, sep = "\t", check.names = FALSE)

# Initializing a vector to store the results
max_dates <- vector("numeric", length = 20)
years <- 1996:2015

# Finding the day of the highest temperature for each year
for (i in 1:length(years)) {
  year <- years[i]
  # Data for the corresponding year
  temp_data <- temps[, as.character(year)]
  
  # Replacing NA values with the mean temperature of that year
  temp_data[is.na(temp_data)] <- mean(temp_data, na.rm = TRUE)
  
  # Extracting the highest temperature and its day
  max_temp <- max(temp_data, na.rm = TRUE)
  max_day <- which.max(temp_data)
  
  # Saving the results
  max_dates[i] <- max_day
  
  cat("Year", year, ": Max Temp =", max_temp, "on Day", max_day, "\n")
}

# Adjusting the plot margins to avoid the "figure margins too large" error
par(mar=c(5.1, 4.1, 4.1, 2.1))

# Analyzing the trend of the highest temperature occurrence day each year
plot(years, max_dates, type = "b", xlab = "Year", ylab = "Day of Max Temperature",
     main = "Day of Max Temperature Each Year")
trend_line <- lm(max_dates ~ years)
abline(trend_line, col = "red") # Adding the trend line

# Examining the slope of the trend line to determine if the end of summer shifts over time
lm_result <- lm(max_dates ~ years)
summary(lm_result)

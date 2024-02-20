# Load required package
install.packages("ggplot2")
library(ggplot2)
install.packages("zoo")
library(zoo)

# Set the file path
file_path <- "C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501 Introduction to Analystic/HW3/temps.txt"

# Read the data
temperature_data <- read.table(file_path, header = TRUE, sep = "\t", check.names = FALSE)

# Define the date range
start_date <- as.Date("1996-07-01")
end_date <- as.Date("1996-10-31")
dates <- seq.Date(start_date, end_date, by = "day")

# Define function to calculate the rolling mean
calculate_rolling_mean <- function(temps, window_size) {
  rollapply(temps, width = window_size, FUN = mean, na.rm = TRUE, partial = TRUE, align = 'right')
}

# Calculate CUSUM using the rolling mean
window_size <- 30
cumsum_values <- list()
for (i in 2:ncol(temperature_data)) {
  rolling_mean <- calculate_rolling_mean(temperature_data[, i], window_size)
  cumsum_values[[i-1]] <- cumsum(temperature_data[, i] - rolling_mean)
}

# Perform trend analysis using CUSUM
for (i in 2:ncol(temperature_data)) {
  cumsum_values[[i-1]] <- cumsum(temperature_data[, i] - mean(temperature_data[, i], na.rm = TRUE))
}

# Calculate the end of summer dates for each year
summer_end_dates <- lapply(cumsum_values, function(cusum) {
  dates[which.max(cusum)]
})

# Analyze trends in CUSUM values for each year
trends <- lapply(cumsum_values, function(cusum) {
  lm(cusum ~ dates)
})

# Combine CUSUM values from each year into a single dataframe
combined_cusum <- do.call(rbind, lapply(1:length(cumsum_values), function(i) {
  data.frame(Date = dates, Year = colnames(temperature_data)[i + 1], CUSUM = cumsum_values[[i]])
}))

# Visualize CUSUM values using ggplot
ggplot(combined_cusum, aes(x = Date, y = CUSUM, color = Year, group = Year)) +
  geom_line() +
  ggtitle("Enhanced CUSUM Analysis of High Temperatures for Atlanta (1996-2015)") +
  xlab("Date") +
  ylab("Cumulative Sum with Rolling Mean") +
  theme_minimal() +
  theme(legend.position = "bottom")

# Output results in a clear, structured format
cat("Yearly End of Summer Dates:\n")
for (i in 1:length(summer_end_dates)) {
  cat(colnames(temperature_data)[i+1], ": ", format(summer_end_dates[[i]], "%Y-%m-%d"), "\n")
}

cat("\nTrend Analysis Results:\n")
for (i in 1:length(trends)) {
  coef <- coef(trends[[i]])
  cat(colnames(temperature_data)[i+1], ": Intercept =", round(coef[1], 2), "Slope =", round(coef[2], 4), "\n")
}

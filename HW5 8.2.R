# Loading the data
crime_data <- read.table("C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501 Introduction to Analystic/HW5/uscrime.txt", header = TRUE)

# Checking variable names (optional)
names(crime_data)

# Constructing the linear regression model, using 'M.F' instead of 'MF'
model <- lm(Crime ~ M + So + Ed + Po1 + Po2 + LF + `M.F` + Pop + NW + U1 + U2 + Wealth + Ineq + Prob + Time, data = crime_data)

# Creating a data frame for predicting the crime rate in a new city
new_city <- data.frame(M = 14.0, So = 0, Ed = 10.0, Po1 = 12.0, Po2 = 15.5, LF = 0.640, `M.F` = 94.0, Pop = 150, NW = 1.1, U1 = 0.120, U2 = 3.6, Wealth = 3200, Ineq = 20.1, Prob = 0.04, Time = 39.0)

# Running the prediction
predicted_crime_rate <- predict(model, newdata = new_city)

# Printing the prediction result
print(predicted_crime_rate)

# Examining the model's coefficients and fit
summary(model)

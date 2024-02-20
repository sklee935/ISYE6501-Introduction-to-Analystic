library(forecast)
library(lubridate)

# 데이터 로드
file_path <- "C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501 Introduction to Analystic/HW4/temps.txt"
temps <- read.table(file_path, header = TRUE, sep = "\t", check.names = FALSE)

# 결과를 저장할 벡터 초기화
max_dates <- vector("numeric", length = 20)
years <- 1996:2015

# 각 연도별 최고 기온의 날짜를 찾기
for (i in 1:length(years)) {
  year <- years[i]
  # 해당 연도의 데이터
  temp_data <- temps[, as.character(year)]
  
  # 비정상성을 처리하기 위한 로그 변환 적용
  log_temp_data <- log(temp_data)
  
  # ARIMA 모델 적용
  fit <- auto.arima(log_temp_data)
  
  # 최고 기온과 해당 날짜 추출
  max_temp <- max(log_temp_data, na.rm = TRUE)
  max_day <- which.max(log_temp_data)
  
  # 결과 저장
  max_dates[i] <- max_day
  
  cat("Year", year, ": Max Temp (Log-scale) =", max_temp, "on Day", max_day, "\n")
}

# 연도별 최고 기온 발생 일자의 추세 분석
plot(years, max_dates, type = "b", xlab = "Year", ylab = "Day of Max Temperature (Log-scale)",
     main = "Day of Max Temperature (Log-scale) Each Year")
abline(lm(max_dates ~ years), col = "red") # 추세선 추가

# 추세선의 기울기를 확인하여 여름의 끝이 시간에 따라 변하는지 분석
lm_result <- lm(max_dates ~ years)
summary(lm_result)

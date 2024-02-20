# 필요한 패키지 설치 및 라이브러리 로드
install.packages("outliers")
library(outliers)

# uscrime.txt 파일 불러오기
file_path <- "C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501 Introduction to Analystic/HW3/uscrime.txt"
crime_data <- read.table(file_path, header = TRUE, sep = "\t")

# Crime 열에 대한 Grubbs' Test 실행
grubbs.result <- grubbs.test(crime_data$Crime)

# 결과 출력
print(grubbs.result)

library(ggplot2)

# 히스토그램 생성
ggplot(crime_data, aes(x=Crime)) + 
  geom_histogram(bins=20, fill="blue", color="black") +
  ggtitle("Crime Rate Histogram") +
  xlab("Crime Rate") +
  ylab("Frequency")

# 상자 그림 생성
ggplot(crime_data, aes(y=Crime)) +
  geom_boxplot(fill="orange", color="black") +
  ggtitle("Crime Rate Boxplot") +
  ylab("Crime Rate")

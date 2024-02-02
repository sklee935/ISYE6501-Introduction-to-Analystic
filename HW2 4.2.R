# Iris 데이터 로드 (공백으로 구분)
iris_data <- read.table("C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501/HW2/iris.txt", header = TRUE)

# 데이터 구조 확인
str(iris_data)

# 'Species' 열 제외 및 데이터 표준화
predictors <- iris_data[, -5]
standardized_data <- scale(predictors)

# k-평균 클러스터링 적용
set.seed(123) # 재현 가능한 결과를 위한 시드 설정
results <- list()
for (k in 2:5) {
  results[[as.character(k)]] <- kmeans(standardized_data, centers = k, nstart = 25)
}

# 클러스터링 결과 및 꽃 종류와의 비교
for (k in names(results)) {
  cat("k =", k, "\n")
  print(table(Cluster = results[[k]]$cluster, Species = iris_data$Species))
  cat("\n")
}

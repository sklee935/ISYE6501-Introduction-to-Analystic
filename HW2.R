# 데이터 로드 및 전처리
cc_data <- read.csv("C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501/HW2/credit_card_data-headers.txt", header = TRUE, sep = "\t")
cc_data$R1 <- as.factor(cc_data$R1)
preProcValues <- preProcess(cc_data, method = c("center", "scale"))
cc_data <- predict(preProcValues, cc_data)

# 데이터 분할: 훈련, 검증, 테스트 세트
set.seed(123)
trainIndex <- createDataPartition(cc_data$R1, p = 0.6, list = FALSE) # 60% 훈련 데이터
validIndex <- createDataPartition(cc_data$R1, p = 0.2, list = FALSE) # 20% 검증 데이터
train_data <- cc_data[trainIndex, ]
valid_data <- cc_data[validIndex, ]
test_data <- cc_data[-c(trainIndex, validIndex), ] # 나머지 20% 테스트 데이터

# 모델 훈련 및 검증
train_control <- trainControl(method = "cv", number = 10)
model <- train(R1 ~ ., data = train_data, method = "knn", trControl = train_control, tuneLength = 20)

# 최적의 k 값 확인
print(model)

# 검증 세트에서 모델 평가
predict_valid <- predict(model, valid_data)
valid_accuracy <- sum(predict_valid == valid_data$R1) / nrow(valid_data)
print(paste("Validation Accuracy:", valid_accuracy))

# 테스트 세트에서 모델 평가
predict_test <- predict(model, test_data)
test_accuracy <- sum(predict_test == test_data$R1) / nrow(test_data)
print(paste("Test Accuracy:", test_accuracy))

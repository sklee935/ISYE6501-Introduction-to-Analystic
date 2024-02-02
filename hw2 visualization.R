# 시각화
library(ggplot2)
for (k in names(results)) {
  iris_data$Cluster <- as.factor(results[[k]]$cluster)
  
  # 꽃잎 변수에 대한 클러스터링 시각화
  p1 <- ggplot(iris_data, aes(x = Petal.Length, y = Petal.Width, color = Cluster)) +
    geom_point() +
    ggtitle(paste("Petal Variables, K =", k))
  petal_path <- paste("C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501/HW2/petal_k", k, ".png", sep="")
  ggsave(petal_path, plot = p1, width = 10, height = 8)
  
  # 꽃받침 변수에 대한 클러스터링 시각화
  p2 <- ggplot(iris_data, aes(x = Sepal.Length, y = Sepal.Width, color = Cluster)) +
    geom_point() +
    ggtitle(paste("Sepal Variables, K =", k))
  sepal_path <- paste("C:/Users/slee/OneDrive - SBP/Desktop/sungkeun/omscs/Spring 2024/ISYE6501/HW2/sepal_k", k, ".png", sep="")
  ggsave(sepal_path, plot = p2, width = 10, height = 8)
}

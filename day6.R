teens <- read.csv('snsdata.csv')
str(teens)

teen_gender <- teens[!is.na(teens$gender), ]
teen_notgender <- teens[is.na(teens$gender), ]

teen_train <- as.data.frame(scale(teen_gender[c(4:40)]))
teen_test <- as.data.frame(scale(teen_notgender[c(4:40)]))
teen_labels <- teen_gender[, c(2)]

library(class)
teen_test_pred <- knn(train = teen_train, test = teen_test, cl = teen_labels, k=5)
table(teen_test_pred)

teens$gender <- ifelse(is.na(teens$gender), teen_test_pred, teens$gender)
teens$gender <- ifelse(teens$gender == '1','F', teens$gender)
teens$gender <- ifelse(teens$gender == '2','M', teens$gender)
table(teens$gender)

#2. iris 또는 iris3 데이터에 대해 3개의 클러스터으로 나누세요. (시각화, ggplot)

iris <- iris
iris_Species <- factor(iris$Species)

feature <- iris[-5]
feature_z <- as.data.frame(lapply(feature, scale))
iris_cluster <- kmeans(feature_z, 3)
iris_cluster$centers

library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point()
iris_cluster$cluster <- as.factor(iris_cluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = iris_cluster$cluster)) + geom_point()



#3. 2번에서 만든 결과에 대해, 임의의 iris 데이터가 입력되었을 때, 어느 클러스터에 속하는지 출력하는 프로그램을 작성하세요.
# -[1.2, 2.1, 1.0, 1.5]-> 입력 ->3번 클러스터

set.seed(435)
idx <- sample(1:nrow(iris), 50)
newdata <- iris[idx, -5]
new = data.frame("Sepal.Length" = 1.2, 'Sepal.Width' = 2.1, 'Petal.Length'=1.0, 'Petal.Width' =1.5)
newdata <- rbind(newdata, new) 

library(class)

#모르겠습니다아아아!
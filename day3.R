hour <- data.frame(c(3,7,6,9,4,2))
score <- data.frame(c(50,80,60,75,70,55))

sample <- data.frame(c(2,5, 10,15))

diabetes <- read.csv('diabetes.csv', header = FALSE)
names(diabetes) <- c('X1', 'X2','X3','X4','X5','X6','X7','x8', 'y')

#knn모델 교차분석
diabetes_z = diabetes[-9]

diabetes_train<- diabetes_z[1:599, ]
diabetes_test <-diabetes_z[600:759, ]

diabetes_train_labels <-diabetes[1:599, 9]
diabetes_test_labels <- diabetes[600:759, 9]


for (i in 1:50){
  if(i%%2 != 0){
    diabetes_test_pred <- knn(train = diabetes_train, test = diabetes_test, cl = diabetes_train_labels, k=i)
    print(i)
    CrossTable(x =diabetes_test_labels, y = diabetes_test_pred)
  }
}
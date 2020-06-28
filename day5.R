setwd('D:/Rdata')

teens <- read.csv('snsdata.csv')
str(teens)
table(teens$gender)

table(teens$gender, useNA = 'ifany')

summary(teens$age)
#13~20: 정상범위 , 비정상범위 : na
teens$age<- ifelse(teens$age>=13 & teens$age<20,teens$age, NA)
summary(teens$age)

#성별 칼럼의 결측값을 적절하게 처리하시오. (knn -> 성별 유추)
#1. 36개의 컬럼을 가지고 Knn을 적용.2. 친구 칼럼을 가지고 성별 유추

teens$female <- ifelse(teens$gender  == 'F' & !is.na(teens$gender), 1, 0)
teens$female

teens$no_gender<-ifelse(is.na(teens$gender), 1, 0)

table(ifelse(teens$gender  == 'F' & !is.na(teens$gender), 1, 0))
#여성 22054 , 남성 8000

table(ifelse(teens$gender== 'F', 1 ,0))
#남성 = 5222, 여성 22054(na는 계산에서 제외됨)

summary(teens$age)

mean(teens$age, na.rm = TRUE) #NA가 제외

#aggregate: 데이터를 그룹한 다음, 그웁 단위로 특정 통계함수
#NA를 제거한 다음 졸업 연도를 가쥰으로 그룹화, 그룹별 평균 연령울 출력

#teens 데이터에서 grouby열을 기준으로 그룹화한 다음 그룹별로 , age 칼럼 값의 평균을 구해라 
aggregate(data=teens, age ~ gradyear, mean, na.rm = TRUE)
avg_ave <- ave(teens$age, teens$gradyear, FUN = function(x) mean(x, na.rm = TRUE))

teens$age <- ifelse(is.na(teens$age), avg_ave, teens$age)

summary(teens$age)

teens$age
interests<- teens[5:40]
interests

interests_z <- as.data.frame(lapply(interests, scale))
#lapply(interests, max)
set.seed(2345)

teen_cluster <- kmeans(interests_z, 5)
teen_cluster

teen_cluster$size
teens$cluster<-teen_cluster$cluster

teens[1:5, c('cluster', 'gender', 'age', 'friends')]
aggregate(data=teens, age~cluster, mean)

#클러스터별로 여학생의 수
aggregate(data=teens, female~cluster, mean)

#각클러스터별로 친구 수의 평균
aggregate(data=teens, friends~cluster, mean)

iris <- iris

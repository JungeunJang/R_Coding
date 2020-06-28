setwd('D:/Rdata')

teens <- read.csv('snsdata.csv')
str(teens)
table(teens$gender)

table(teens$gender, useNA = 'ifany')

summary(teens$age)
#13~20: ������� , ��������� : na
teens$age<- ifelse(teens$age>=13 & teens$age<20,teens$age, NA)
summary(teens$age)

#���� Į���� �������� �����ϰ� ó���Ͻÿ�. (knn -> ���� ����)
#1. 36���� �÷��� ������ Knn�� ����.2. ģ�� Į���� ������ ���� ����

teens$female <- ifelse(teens$gender  == 'F' & !is.na(teens$gender), 1, 0)
teens$female

teens$no_gender<-ifelse(is.na(teens$gender), 1, 0)

table(ifelse(teens$gender  == 'F' & !is.na(teens$gender), 1, 0))
#���� 22054 , ���� 8000

table(ifelse(teens$gender== 'F', 1 ,0))
#���� = 5222, ���� 22054(na�� ��꿡�� ���ܵ�)

summary(teens$age)

mean(teens$age, na.rm = TRUE) #NA�� ����

#aggregate: �����͸� �׷��� ����, �׿� ������ Ư�� ����Լ�
#NA�� ������ ���� ���� ������ �������� �׷�ȭ, �׷캰 ��� ���ɿ� ���

#teens �����Ϳ��� grouby���� �������� �׷�ȭ�� ���� �׷캰�� , age Į�� ���� ����� ���ض� 
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

#Ŭ�����ͺ��� ���л��� ��
aggregate(data=teens, female~cluster, mean)

#��Ŭ�����ͺ��� ģ�� ���� ���
aggregate(data=teens, friends~cluster, mean)

iris <- iris
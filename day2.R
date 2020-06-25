usedcars <- read.csv("usedcars.csv", stringsAsFactors = TRUE)
usedcars
#�о�� �� ���� �����͸� ���ڷ� �о�� �Ѵ� / Factor���·� �о�� �Ѵ�. stringsAsFactors�� �Ǵ�

str(usedcars)
#���������� �ϴ� ���������� �ٲ��ش�.
#str : info = level�����ؾ���(model : 3 levels 3���� ����)
summary(usedcars) # describe�� ���� / �μ��� �ϳ��� ��
summary(usedcars[c('price','mileage')]) #���ͷ� ��� �μ� �ϳ��� ������

mean(c(36,44,56)) # ���
median(c(36,44,56)) # ������
range(usedcars$price) # �ּڰ�, �ִ� �� �� ����.
diff(range(usedcars$price)) # ���� ���� �� �� ����
#IQR : Q3 - Q1

boxplot(usedcars)
IQR(usedcars$price)
quantile(usedcars$price) #fivenumber
seq(from=0, to=1, by=0.2)
quantile(usedcars$price, probs=seq(from=0, to=1, by=0.2)) # 6number�� ��ȯ
boxplot(usedcars$price, ylab = 'Price', main="Boxplot")
hist(usedcars$price, xlab = 'x',ylab = 'num', main = "hist") # main : ���� / ylab : y��
var(usedcars$price) # �л�
sd(usedcars$price) # ǥ������

#68 / 95 / 99.7
# 2�ñ׸� : 68%(-�ñ׸����� �ñ׸�����)
# 4�ñ׸� : 95%(-2�ñ׸����� 2�ñ׸�����)
# 6�ñ׸� : 99.7%(-3�ñ׸����� 3�ñ׸�����)
#��ġ���� : summary
#���ֺ��� (level�� ����?) : table

table(usedcars$model)
table(usedcars$year) # -> ��ġ������ table�� ������ : ���еȴ�.(value_counts����)
round(prop.table(table(usedcars$model))*100, digits = 1) #������ ���´�. round(x,dight=y) �Ҽ��� y�ڸ�����ŭ(�ݿø�)

#�Ϻ���(���� 1�� ���) / �̺���(���� 2���� ����) / �ٺ���(���� �������� ����)
plot(x=usedcars$mileage, y = usedcars$price)

#�̿�����ǥ : �� �������� ���踦 ����
#model : ������ / color : ������
install.packages("gmodels") # = pip install ��Ű����
library(gmodels) #����� crosstable�ν�

usedcars$color %in% c("Black", "Gray", "Silver", "Gold")
usedcars$conservative <-usedcars$color %in% c("Black", "Gray", "Silver", "Gold") # ���ԵǸ� true �ƴϸ� false
table(usedcars$conservative)
CrossTable(x = usedcars$model, y = usedcars$conservative) # ��(����)�� ��(����) ���ÿ� ������ �� ���ΰ�?

cars #�ڵ��� �ӵ� (������ ���µ� �̹� ������� �ִ� ����)
str(cars)
head(cars) # �ǹ̾��� 6��
summary(cars)

plot(cars$speed, cars$dist, xlab = 'speed(MPH)', ylab = 'distance(feet)', main='Stopping distance of cars based on speed')
cor(cars$speed, cars$dist)


#linear regresstion
#lm(���Ӻ��� ~ ����������, data)
mymodel <- lm(dist~speed,cars)
mymodel

#predict

newd <- data.frame(speed = c(10, 30, 50, 100))
newd
#���� ȸ�͸������� ���ο� ������ �����ӿ� ���� - ���� �ϱ�
predict(mymodel, newd)
#�ŷ� ������ ����
predict(mymodel, newd, interval = 'confidence')

#����ȸ�Ϳ��� ������ �ϳ��� ����  -> �ܺ��� ����ȸ�ͺ���
#����ȸ�Ϳ��� ������ �ϳ� �̻��� ��� -> �ٺ��� ����ȸ��


mymodel<- lm(dist ~ speed+wind+temp, cars)
#h(x) = w1x1+w2x2+w3x3 + b

#Knn �˰����� (K-nearest neighbors, ���������� �ǹ�)
#k�� �̿��� �� 

#��Ŭ���� �˰�����
#������Ÿ�� �Ÿ� �˰�����


wbcb <- read.csv('wisc_bc_data.csv', stringsAsFactors = FALSE)
str(wbcb)

#���� ��� ~ �پ��� Ư���� 
wbcb[1]
wbcb[2]

wbcb <- wbcb[-1] #ù��° Į�� ����� ������ 
# ������ B�� ���°� ���� 
length(which(wbcb$diagnosis == 'B'))
table(wbcb$diagnosis)

factor(wbcb$diagnosis, labels = c("B", "M"))
str(wbcb)

wbcb$diagnosis <-factor(wbcb$diagnosis, levels = c("B", "M"), labels= c("Begins", "Maliganent"))
typeof(table(wbcb$diagnosis))

table(wbcb$diagnosis)[1]

round(prop.table(table(wbcb$diagnosis))*100, 1) #�ۼ�Ʈ�� ����� �ݿø� �ع�����!

wbcb['radius_mean']

#���ϴ� ������ �����ϱ� 
wbcb[c('radius_mean', 'area_mean', 'smoothness_mean')]

summary(wbcb[c('radius_mean', 'area_mean', 'smoothness_mean')])

#����ȭ �Լ� �����
normalize<- function(x){
  #print(min(x))
  return((x-min(x))/ (max(x)-min(x)))
}
normalize(c(1,2,3,4,5))

#������ �������� ������ ������ ���͵�� ������ ����Ʈ
wbcb[2:31]
typeof(lapply(wbcb[2:31],normalize))

wbcb_n <- as.data.frame(lapply(wbcb[2:31],normalize))

summary(wbcb_n$area_mean)

range(wbcb$area_mean)

wbcb_train <-wbcb_n[1:469,]
wbcb_test <- wbcb_n[470:569, ]

# �Ϲ����� ��ü������ �� -> Ʈ���̴�(70%), �׽�Ʈ(30%)
# Ʈ���̴� ������ _> �˰����� -? �𵨸� -> �з��� -> ���(��Ȯ��)-> �� ����

wbcb_train_labels <-wbcb[1:469, 1]
wbcb_test_labels <- wbcb[470:569, 1]
#label <- wbcb[1:469 , 1]

library(class)

wbcb_test_pred <- knn(train = wbcb_train, test = wbcb_test, cl = wbcb_train_labels, k=5)
wbcb_test_pred

#���� �м�(crosstable) : �������� ���ü��� ���θ� ���� 

install.packages("gmodels")
library('gmodels')
CrossTable(x =wbcb_test_labels, y = wbcb_test_pred)

wbcb_test_ex <- knn(train = wbcb_train, test = wbcb_test, cl= wbcb_train_labels, k=5)
wbcb_test_ex

# ù��°��� �Ǽ��к�
x = c(12.32,12.39,78.85,464.1,0.1028,0.06981,0.03987,0.037,0.1959,0.05955,0.236,0.6656,1.67,17.43,0.008045,0.0118,0.01683,0.01241,0.01924,0.002248,13.5,15.64,86.97,549.1,0.1385,0.1266,0.1242,0.09391,0.2827,0.06771)
wbcd_test_ex<-knn(train = wbcd_train, 
                  test = x, 
                  cl = wbcd_train_lables, 
                  k= 5)
wbcd_test_ex
#ǥ��ȭ
wbcd_z<-as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)

#knn�� �����м�

wbcb_train_z <-wbcb_z[1:469,]
wbcb_test_z <- wbcb_z[470:569, ]

wbcb_train_labels <-wbcb[1:469, 1]
wbcb_test_labels <- wbcb[470:569, 1]


wbcb_test_pred_1 <- knn(train = wbcb_train_z, test = wbcb_test_z, cl = wbcb_train_labels, k=1)
CrossTable(x =wbcb_test_labels, y = wbcb_test_pred_1)

wbcb_test_pred_5 <- knn(train = wbcb_train_z, test = wbcb_test_z, cl = wbcb_train_labels, k=5)
wbcb_test_pred_11 <- knn(train = wbcb_train_z, test = wbcb_test_z, cl = wbcb_train_labels, k=11)
wbcb_test_pred_15 <- knn(train = wbcb_train_z, test = wbcb_test_z, cl = wbcb_train_labels, k=15)
wbcb_test_pred_21 <- knn(train = wbcb_train_z, test = wbcb_test_z, cl = wbcb_train_labels, k=21)
wbcb_test_pred_27 <- knn(train = wbcb_train_z, test = wbcb_test_z, cl = wbcb_train_labels, k=27)

CrossTable(x =wbcb_test_labels, y = wbcb_test_pred_5)
CrossTable(x =wbcb_test_labels, y = wbcb_test_pred_11)
CrossTable(x =wbcb_test_labels, y = wbcb_test_pred_15)
CrossTable(x =wbcb_test_labels, y = wbcb_test_pred_21)
CrossTable(x =wbcb_test_labels, y = wbcb_test_pred_27)












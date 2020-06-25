usedcars <- read.csv("usedcars.csv", stringsAsFactors = TRUE)
usedcars
#읽어야 할 문자 데이터를 문자로 읽어야 한다 / Factor형태로 읽어야 한다. stringsAsFactors로 판단

str(usedcars)
#섞여있으면 일단 많은것으로 바꿔준다.
#str : info = level참고해야함(model : 3 levels 3개의 종류)
summary(usedcars) # describe와 같음 / 인수가 하나만 들어감
summary(usedcars[c('price','mileage')]) #벡터로 묶어서 인수 하나로 만들어라

mean(c(36,44,56)) # 평균
median(c(36,44,56)) # 중위수
range(usedcars$price) # 최솟값, 최댓값 알 수 있음.
diff(range(usedcars$price)) # 값의 차를 알 수 있음
#IQR : Q3 - Q1

boxplot(usedcars)
IQR(usedcars$price)
quantile(usedcars$price) #fivenumber
seq(from=0, to=1, by=0.2)
quantile(usedcars$price, probs=seq(from=0, to=1, by=0.2)) # 6number로 변환
boxplot(usedcars$price, ylab = 'Price', main="Boxplot")
hist(usedcars$price, xlab = 'x',ylab = 'num', main = "hist") # main : 제목 / ylab : y축
var(usedcars$price) # 분산
sd(usedcars$price) # 표준편차

#68 / 95 / 99.7
# 2시그마 : 68%(-시그마부터 시그마까지)
# 4시그마 : 95%(-2시그마부터 2시그마까지)
# 6시그마 : 99.7%(-3시그마부터 3시그마까지)
#수치변수 : summary
#범주변수 (level로 구분?) : table

table(usedcars$model)
table(usedcars$year) # -> 수치변수에 table을 넣으면 : 구분된다.(value_counts느낌)
round(prop.table(table(usedcars$model))*100, digits = 1) #비율로 나온다. round(x,dight=y) 소수점 y자리수만큼(반올림)

#일변량(변수 1개 통계) / 이변량(변수 2개의 관계) / 다변량(변수 여러개의 관계)
plot(x=usedcars$mileage, y = usedcars$price)

#이원교차표 : 두 변수간의 관계를 관찰
#model : 범주형 / color : 범주형
install.packages("gmodels") # = pip install 패키지명
library(gmodels) #해줘야 crosstable인식

usedcars$color %in% c("Black", "Gray", "Silver", "Gold")
usedcars$conservative <-usedcars$color %in% c("Black", "Gray", "Silver", "Gold") # 포함되면 true 아니면 false
table(usedcars$conservative)
CrossTable(x = usedcars$model, y = usedcars$conservative) # 모델(독립)이 색(종속) 선택에 영향을 줄 것인가?

cars #자동차 속도 (만든적 없는데 이미 만들어저 있는 변수)
str(cars)
head(cars) # 의미없는 6개
summary(cars)

plot(cars$speed, cars$dist, xlab = 'speed(MPH)', ylab = 'distance(feet)', main='Stopping distance of cars based on speed')
cor(cars$speed, cars$dist)


#linear regresstion
#lm(종속변수 ~ 독립변수들, data)
mymodel <- lm(dist~speed,cars)
mymodel

#predict

newd <- data.frame(speed = c(10, 30, 50, 100))
newd
#만든 회귀모형으로 새로운 데이터 프레임에 적용 - 예측 하기
predict(mymodel, newd)
#신뢰 수준을 적용
predict(mymodel, newd, interval = 'confidence')

#선형회귀에서 변수가 하나인 경우는  -> 단변량 선형회귀변수
#선형회귀에서 변수가 하나 이상인 경우 -> 다변량 선형회귀


mymodel<- lm(dist ~ speed+wind+temp, cars)
#h(x) = w1x1+w2x2+w3x3 + b

#Knn 알고리즘 (K-nearest neighbors, 유유상종의 의미)
#k의 이웃의 수 

#유클리드 알고리즘
#레번슈타인 거리 알고리즘


wbcb <- read.csv('wisc_bc_data.csv', stringsAsFactors = FALSE)
str(wbcb)

#진단 결과 ~ 다양한 특성값 
wbcb[1]
wbcb[2]

wbcb <- wbcb[-1] #첫번째 칼럼 드랍한 데이터 
# 진단이 B로 나온거 새기 
length(which(wbcb$diagnosis == 'B'))
table(wbcb$diagnosis)

factor(wbcb$diagnosis, labels = c("B", "M"))
str(wbcb)

wbcb$diagnosis <-factor(wbcb$diagnosis, levels = c("B", "M"), labels= c("Begins", "Maliganent"))
typeof(table(wbcb$diagnosis))

table(wbcb$diagnosis)[1]

round(prop.table(table(wbcb$diagnosis))*100, 1) #퍼센트로 만들고 반올림 해버리기!

wbcb['radius_mean']

#원하는 데이터 추출하기 
wbcb[c('radius_mean', 'area_mean', 'smoothness_mean')]

summary(wbcb[c('radius_mean', 'area_mean', 'smoothness_mean')])

#정규화 함수 만들기
normalize<- function(x){
  #print(min(x))
  return((x-min(x))/ (max(x)-min(x)))
}
normalize(c(1,2,3,4,5))

#데이터 프레임은 동일한 길이의 벡터들로 구성된 리스트
wbcb[2:31]
typeof(lapply(wbcb[2:31],normalize))

wbcb_n <- as.data.frame(lapply(wbcb[2:31],normalize))

summary(wbcb_n$area_mean)

range(wbcb$area_mean)

wbcb_train <-wbcb_n[1:469,]
wbcb_test <- wbcb_n[470:569, ]

# 일반적인 전체데이터 셋 -> 트래이닝(70%), 테스트(30%)
# 트레이닝 데이터 _> 알고리즘 -? 모델링 -> 분류모델 -> 결과(정확도)-> 모델 개선

wbcb_train_labels <-wbcb[1:469, 1]
wbcb_test_labels <- wbcb[470:569, 1]
#label <- wbcb[1:469 , 1]

library(class)

wbcb_test_pred <- knn(train = wbcb_train, test = wbcb_test, cl = wbcb_train_labels, k=5)
wbcb_test_pred

#교차 분석(crosstable) : 변수간의 관련성의 여부를 보는 

install.packages("gmodels")
library('gmodels')
CrossTable(x =wbcb_test_labels, y = wbcb_test_pred)

wbcb_test_ex <- knn(train = wbcb_train, test = wbcb_test, cl= wbcb_train_labels, k=5)
wbcb_test_ex

# 첫번째사람 악성분별
x = c(12.32,12.39,78.85,464.1,0.1028,0.06981,0.03987,0.037,0.1959,0.05955,0.236,0.6656,1.67,17.43,0.008045,0.0118,0.01683,0.01241,0.01924,0.002248,13.5,15.64,86.97,549.1,0.1385,0.1266,0.1242,0.09391,0.2827,0.06771)
wbcd_test_ex<-knn(train = wbcd_train, 
                  test = x, 
                  cl = wbcd_train_lables, 
                  k= 5)
wbcd_test_ex
#표준화
wbcd_z<-as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)

#knn모델 교차분석

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













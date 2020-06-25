setwd('D:/Rdata')

library(arules)

groceries<-read.transactions('groceries.csv', sep=',')
groceries

View(groceries)
summary(groceries)

print(9835*169*0.026) 
#행XitemsXdensity
#한달동안 총 : 43000여개의 아이템이 판매

inspect(groceries[1:5])
groceries[, 1:3]

itemFrequency(groceries[,1:3])
#지지도: 전체거래중 해당 아이템 거래 비율

itemFrequencyPlot(groceries, support=0.1)
image(groceries[1:5]) 
groceries[1:5]

image(groceries[1:100]) #희소행렬

#169개 종류의 상품
#2의 169승 -1 => 아이템 항목 집합
#연관규칙:아이템 항목 집합(X) -> 아이템 항목집합(Y)
#연관규칙개수:아이템 항목 집합(X)*아이템 항목집합(Y)
#전체 연관규칙 중에서 향상도가 가장높은 연관규칙 10개를 뽑아보자
#Pruning! (Apriori Prune Algorithm)
#A(설탕) 구매횟수가 0이라면 가지치기(pruning)를 해주자
#ex) A->B, AB->C ...A가 들어가는 모든 규칙 제거
#Apriori 는 transaction type 이어야 한다.
#apriori(data, parameter = NULL, appearance = NULL, control = NULL)


groceryryles<- apriori(groceries, parameter = list(support = 0.005, confidence = 0.2, minlen=2))
summary(groceryryles)
#X(lhs) -> Y(rls)
# {apple} -> {banana, water} : conf = 0.7 연관규칙이 잘 맞음
# 향상도 1보다 작음 = 사과룰 샀다고  바나나랑 물을 사지 않는다!

inspect(groceryryles[1:3])
#lhs                 rhs                support     confidence coverage   lift     count
#[1] {cake bar} => {whole milk}       0.005592272 0.4230769  0.01321810 1.655775 55   케익바 사고 홀 우유사는 경우 55%, 케익바를 사는 사람중에서, whole 밀크를 산 사람은 42%, 
#lift => 우유를 산 사람 중에서, 케익바를 산 경우가 분모, 케익바와 우유를 산 경우가 분자 
#[2] {dishes}   => {other vegetables} 0.005998983 0.3410405  0.01759024 1.762550 59   
#[3] {dishes}   => {whole milk}       0.005287239 0.3005780  0.01759024 1.176357 52   

inspect(sort(groceryryles, by = 'lift')[1:15])

herbsrules <-subset(groceryryles, items %in% 'herbs')
inspect(herbsrules)

berriesrules <-subset(groceryryles, items %in% 'berries')
inspect(berriesrules)

write(groceryryles, file = 'myRule.csv', sep = ",",  row.names=FALSE)

df <- as(groceryryles, 'data.frame')
str(df)
































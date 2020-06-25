setwd('D:/Rdata')

library(arules)

groceries<-read.transactions('groceries.csv', sep=',')
groceries

View(groceries)
summary(groceries)

print(9835*169*0.026) 
#��XitemsXdensity
#�Ѵ޵��� �� : 43000������ �������� �Ǹ�

inspect(groceries[1:5])
groceries[, 1:3]

itemFrequency(groceries[,1:3])
#������: ��ü�ŷ��� �ش� ������ �ŷ� ����

itemFrequencyPlot(groceries, support=0.1)
image(groceries[1:5]) 
groceries[1:5]

image(groceries[1:100]) #������

#169�� ������ ��ǰ
#2�� 169�� -1 => ������ �׸� ����
#������Ģ:������ �׸� ����(X) -> ������ �׸�����(Y)
#������Ģ����:������ �׸� ����(X)*������ �׸�����(Y)
#��ü ������Ģ �߿��� ��󵵰� ������� ������Ģ 10���� �̾ƺ���
#Pruning! (Apriori Prune Algorithm)
#A(����) ����Ƚ���� 0�̶�� ����ġ��(pruning)�� ������
#ex) A->B, AB->C ...A�� ���� ��� ��Ģ ����
#Apriori �� transaction type �̾�� �Ѵ�.
#apriori(data, parameter = NULL, appearance = NULL, control = NULL)


groceryryles<- apriori(groceries, parameter = list(support = 0.005, confidence = 0.2, minlen=2))
summary(groceryryles)
#X(lhs) -> Y(rls)
# {apple} -> {banana, water} : conf = 0.7 ������Ģ�� �� ����
# ��� 1���� ���� = ����� ��ٰ�  �ٳ����� ���� ���� �ʴ´�!

inspect(groceryryles[1:3])
#lhs                 rhs                support     confidence coverage   lift     count
#[1] {cake bar} => {whole milk}       0.005592272 0.4230769  0.01321810 1.655775 55   ���͹� ��� Ȧ ������� ��� 55%, ���͹ٸ� ��� ����߿���, whole ��ũ�� �� ����� 42%, 
#lift => ������ �� ��� �߿���, ���͹ٸ� �� ��찡 �и�, ���͹ٿ� ������ �� ��찡 ���� 
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































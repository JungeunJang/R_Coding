data(Epub)

summary(Epub)

#연관규칙 연습
#support, cofidence, minien = 2
# sort(by= '기준열')
# in 연산자, 시각화
# csv파일까지 저장

library(arules)
inspect(Epub[1:5])
itemFrequency(Epub[,1:5])

itemFrequencyPlot(Epub,support= 0.01)
image(Epub[1:10])
image(Epub[1:1000])

#아포리써보기
EpubRule <- apriori(Epub, parameter = list(support = 0.002, confidence = 0.01, minlen = 2))
summary(EpubRule)

inspect(EpubRule[1:10])
inspect(sort(EpubRule, by = 'lift'))

#부분집합
doc_4ac_rules <-subset(EpubRule, items %in% 'doc_4ac')
inspect(doc_4ac_rules)

doc_16e_rules <-subset(EpubRule, items %in% 'doc_16e')
inspect(doc_16e_rules)

doc_972_rules <-subset(EpubRule, items %in% 'doc_972')
inspect(doc_972_rules)

#저장하기
rite(EpubRule, file = 'EpubRule.csv', sep = ",",  row.names=FALSE)

#데이터 프레임으로 만들기
df <- as(EpubRule, 'data.frame')
str(df)




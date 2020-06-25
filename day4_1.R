data(Epub)

summary(Epub)

#������Ģ ����
#support, cofidence, minien = 2
# sort(by= '���ؿ�')
# in ������, �ð�ȭ
# csv���ϱ��� ����

library(arules)
inspect(Epub[1:5])
itemFrequency(Epub[,1:5])

itemFrequencyPlot(Epub,support= 0.01)
image(Epub[1:10])
image(Epub[1:1000])

#�������Ẹ��
EpubRule <- apriori(Epub, parameter = list(support = 0.002, confidence = 0.01, minlen = 2))
summary(EpubRule)

inspect(EpubRule[1:10])
inspect(sort(EpubRule, by = 'lift'))

#�κ�����
doc_4ac_rules <-subset(EpubRule, items %in% 'doc_4ac')
inspect(doc_4ac_rules)

doc_16e_rules <-subset(EpubRule, items %in% 'doc_16e')
inspect(doc_16e_rules)

doc_972_rules <-subset(EpubRule, items %in% 'doc_972')
inspect(doc_972_rules)

#�����ϱ�
rite(EpubRule, file = 'EpubRule.csv', sep = ",",  row.names=FALSE)

#������ ���������� �����
df <- as(EpubRule, 'data.frame')
str(df)



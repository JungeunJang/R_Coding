print("hello world")
#R = Python + Numpy + Pandas + Matplotlib 라고 웨이 포뮬라님께서 정의하셨다.
#벡터
f=c('apple','grape','orange')#c함수: 벡터생성
n=c(3,2,5)
s=c(TRUE,FALSE,FALSE)
S
f[2]
f[1:3]
f[-2] #-2로 2번째 객체가 빠지고 출력
f[c(TRUE,FALSE,FALSE)] #true, flase로 boolean으로 참조 가능
f[s] #객체로도 가능
#factor() : 범주형 변수 -> 이러한 변수만 올수 있다고 선언
gender = factor(c("F","M","M"))
gender
blood <-factor(c("O","AB","A"),levels=c("O","AB","A","B"))
#명시적으로 levels를 명시해줄 필요가 있음
blood
hakjum <- factor(c("C","A","B","F"),levels=c('A','B','C','D','F'),order=TRUE)
hakjum
#리스트: 순서 집합 저장(벡터도 마찬가지)
#데이터 간에 타입이 달라도 저장됨
f[1]
n[1]
s[1]
mylist=list(myf = f[1],myn=n[1],mys=s[1])
mylist
typeof(mylist)
mylist$myn
mylist[2]
mylist[[2]]
df<-data.frame(f,n,s)
df
typeof(df)
str(df) # chr : 문자열, num : 숫자형, S : boolean
df$f
matrix(c(1,2,3,4,5,6),nrow=2) #열이
m<-matrix(c(1,2,3,4,5,6),ncol=2) #행이 2개
m[1,2]
m[1,]
m[,2]
usedcars <- read.csv("usedcars.csv")
usedcars
usedcars<-read.csv("usedcars.csv", stringsAsFactors = TRUE)
usedcars
str(usedcars)



usedcars <- read.csv("usedcars.csv", stringsAsFactors = TRUE)
usedcars
str(usedcars)

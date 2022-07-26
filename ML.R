strTableName <- iris
iris_dataset <- read.table(strTableName, header = FALSE, sep=",")
#data exploration
dim(iris_dataset)
#show header
head(iris_dataset)
colnames(iris_dataset)<-
  c("Sepal.length","Sepal.Width","Petal.Length","Petal.Width","Species")
head(iris_dataset)

summary(iris_dataset)
#scatter plot
sp<- ggplot(data=iris_dataset, aes(x=Petal.Length,y=Petal.Width)) +
  geom_point(aes(color=Species,shape=Species)) +xlab("Petal Length") +ylab("Petal Width")+ggtitle("Petal Length-Width") + geom_smooth(method='lm')
print(sp)
#histo
histogram <- ggplot(data=iris_dataset,aes(x=Sepal.Width))+
  geom_histogram(binwidth=0.2,color="black",aes(fill=Species))+xlab("Sepal Width")+ylab("Freqeuncy")+ggtitle("Histogram of Sepal Width")+theme_economist()
print(histogram)
#box plot
box <- ggplot(data=trainset,aes(x=Species,y=Sepal.Length))+
  geom_boxplot(aes(fill=Species))+ylab("Sepal Length")+ ggtitle("Iris Boxplot")+
  stat_summary(fun.y=mean,geom="point",shape=5,size=4)
print(box)
#divide data set into training and test sets 80/20
index<- createDataPartition(iris_dataset$Species,p=0.80,list=FALSE)
testset<- iris_dataset[-index,]
trainset<-iris_dataset[index,]
#decision tree classifier
fit<-rpart(Species~.,data=trainset, method='class')
#decision tree
rpart.plot(fit)
#predict classification
pred_train<-predict(object=fit,newdata=trainset[,1:4],type="class")
#classification metrics
confusionMatrix(pred_train, trainset$Species)
#predict classification
pred_test<-predict(object=fit,newdata=testset[,1:4],type="class")
#show classification metrics
confusionMatrix(pred_test,testset$Species)

library(caret)
set.seed(1024)
data <- read.csv('data/pml-training.csv')
trainIndex <- createDataPartition(y=data$classe, p=0.6, list=FALSE)
data.train <- data[trainIndex, ]
data.valid <- data[-trainIndex, ]
data.test <- read.csv('data/pml-testing.csv')

no_na <- sapply(data.train, function(x) !sum(is.na(x)))
data.train.cleaned = data.train[, no_na][, -c(1:4)]

fitControl <- trainControl(method = "cv",
                           number = 10, repeats = 10)

modFit <- train(as.factor(classe)~., data=data.train.cleaned, method='rf', 
                trControl = fitControl, 
                verbose=FALSE)
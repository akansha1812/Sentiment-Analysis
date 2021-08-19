/*Sys.setenv(GITHUB_PAT = '')
Sys.setenv(MONKEYLEARN_KEY ='')
install.packages('devtools')
devtools::install_github("ropensci/monkeylearn")
*/

library(monkeylearn)
library(RTextTools)
library(e1071)

setwd("")

testFile = "./test.txt"


conn = file(testFile,open="r")
lines <- readLines(conn)
res= ""
test=rbind()
for (i in 1:length(lines)){
  if(lines[i] == "<--->"){
    temp = rbind(c(res))
    test= rbind(test,temp)
    res= ""
  }
  else{
    temp  =  gsub(pattern="[[:punct:]]", lines[i], replacement=" ")
    res  = paste(res,temp)
  }
}

test
actual = c('Positive','Positive','Positive','Positive','Positive','Negative','Negative','Negative','Negative','Negative','Neutral','Neutral','Neutral','Neutral','Neutral')
request <- test
output <-monkeylearn_classify(request,
                     classifier_id = "cl_Jx8qzYJh")
predicted <- rbind(output$label)
output$label
table(predicted,actual)
recall_accuracy(predicted,actual)


wd <- getwd()
if (regexpr("app$",wd)<0){
  setwd("./app")
}
#df <- read.csv("3543_2019.csv",header=T, row.names = 1, skip = 1)
df <- read.csv("3543_2019.csv",header=T, skip = 1)
colnames(df) <- c("Date", "Open", "High", "Low", "Close")
list <- df[,c(1,2,3,4)]
list2 <- data.frame(t(list))
colnames(list2) <- rownames(list)
#boxplot(startlist, highlist, lowlist)
#boxplot(list2)
library("quantmod")

comeda_xts <- as.xts(read.zoo(df))
chartSeries(
  comeda_xts,
  subset = "2019-01",
  type = "candlesticks"
)
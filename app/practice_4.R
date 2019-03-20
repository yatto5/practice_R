# fun1 <- function(x){
#   a <- x^2
#   b <- x+ 10
#   ans <- a+ b
#   return(ans)
# }
# 
# fun1(10)

fun2 <- function(dat,num){
  ans <- lm(df$病気~., data = dat, family = binomial)
  s.ans <- summary(ans)
  coe <- s.ans$coefficients
  N <- nrow(df)
  aic <- AIC(ans)
  result <- cbind(coe, aic, N)
  result[2:nrow(result), 5:6] <- ""
  filename <- paste("logistic回帰-sample-", num, "変数.csv", sep = "")
  write.table(matrix(c("",colnames(result)), nrow = 1),
              filename, append = F, quote = F, sep = ",",
              row.names = F, col.names = F)
  write.table(result, filename, append = T, quote = F,
              sep = ",", row.names = T, col.names = F)
  write.table("", filename, append = T, quote = F, sep = ",",
              row.names = F, col.names = F)
}

wd <- getwd()
if (regexpr("app$",wd)<0){
  setwd("./app")
}

df <- read.csv("sample-data.csv", header = T, row.names = 1)
fun2(df[,c(5,1,2,3)],3)
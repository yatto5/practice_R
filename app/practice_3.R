wd <- getwd()
if (regexpr("app$",wd)<0){
 setwd("./app")
}

# y <- c(1,3,4,10,5,1,3,14,21)
# x <- c(10,20,10,40,50,10,10,20,70)
# 
# #回帰係数の取得
# ans <- lm(y~x)
# #ans
# 
# #回帰分析の詳細データ
# s.ans <- summary(ans)
# s.ans
# 
# #回帰係数を抽出
# coe <- s.ans$coefficients
# #AICをを抽出
# aic <- AIC(ans)
# 
# #解析データの総数を抽出
# N <- length(y)
# 
# #結果をまとめる
# result <- cbind(coe, aic, N)
# result[2,5:6] <- ""
# 
# #ファイルへ出力
# write.table(matrix(c("",colnames(result)),nrow = 1), 
#             "回帰分析.csv", append = T, quote = F,
#             sep = ",", row.names = F, col.names = F)
# write.table(result, "回帰分析.csv", append = T, 
#             quote = F, sep = ",", row.names = T,
#             col.names = F)

#CSVファイルのデータ解析
#CSVファイルの読み込み
df <- read.csv("sample-data.csv", header = T, row.names = 1)
dat <- df[,c(3,2,1)]

#ans <- lm(df$肺活量~df$血圧+ df$体重)
ans <- lm(df$肺活量~.,data = dat)
s.ans <- summary(ans)

coe <- s.ans$coefficients
N <- nrow(df)
aic <- AIC(ans)

result <- cbind(coe, aic, N)
result[2:nrow(result),5:6] <- ""

filename <- "重回帰出力test1.csv"
write.table(matrix(c("",colnames(result)),
                   nrow = 1), filename, append = T,
            quote = F, sep = ",", row.names = F,
            col.names = F)
write.table(result, filename, append = T, quote = F,
            sep = ",", row.names = T, col.names = F)
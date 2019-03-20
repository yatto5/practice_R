wd <- getwd()
if (regexpr("app$",wd)<0){
  setwd("./app")
}

df <- read.csv("sample-data.csv", header = T, row.names = 1)
ans <- lm(df[,c(3)]~df[,c(1)])

f1 <- "practice_5_sample1.png"
f2 <- "practice_5_sample2.jpeg"

png(f1, width = 800, height = 600)
plot(df[,c(1,3)])
lines(df[,c(1)], fitted(ans), col = "red")
dev.off()
plot(df[,c(1,3)])
lines(df[,c(1)], fitted(ans), col = "red")
dev.copy(jpeg, f2, width = 900, height = 675)
dev.off()

#dev.off()


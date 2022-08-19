df <- read.csv("https://stepic.org/media/attachments/lesson/11481/evals.csv")

for (i in 1:nrow(df)){print(df$score[i])}

df$quality <- rep(NA, nrow(df))

for (i in 1:nrow(df)){
  if (df$score[i] > 4){
    df$quality[i] <- "good"
  } else {df$quality[i] <- "bad"}
}

df$quality2 <- ifelse(df$score > 4, 'good', 'bad')

a <- AirPassengers
a
v1 <- as.vector(a)
v1
v2 <- v1[2:length(v1)]
v2
i <- 1
good_months <- vector()
while(i < length(v1)){
  if (v2[i] > v1[i]){
    good_months <- c(good_months, v2[i])
  }
  i = i + 1
}
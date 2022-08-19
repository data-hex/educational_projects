#task 1.9.9
library(ggplot2)
d <- diamonds


obj <- ggplot(d, aes(x = color, fill = cut))+
  geom_bar(stat = 'count', position=position_dodge())
obj

#task 1.9.5
sr <- apply(iris[1:4], 2, mean)
iris$x1 <- ifelse(iris$Sepal.Length > sr[1], 1, 0)
iris$x2 <- ifelse(iris$Sepal.Width > sr[2], 1, 0)
iris$x3 <- ifelse(iris$Petal.Length > sr[3], 1, 0)
iris$x4 <- ifelse(iris$Petal.Width > sr[4], 1, 0)
iris$important_cases <- as.factor(ifelse((iris$x1 + iris$x2 + iris$x3 + iris$x4) >= 3, 'Yes', 'No'))


#task 1.9.6

get_important_cases <- function(x){
  df <- x
  mean_df <- sapply(df, mean)
  
  #проверяем каждую строку,суммируем 1 и 0
  x <- apply(df,1,function (x) sum(x > mean_df))
  
  #создаем ряд
  x2 <- ifelse(x > floor(ncol(df)/2), 1,0)
  
  #ряд чисел как фактор   
  df$important_cases <- factor(x2, levels = c(0, 1), labels = c("No","Yes"))
  return(df)}

test_data <- data.frame(V1 = c(16, 21, 18), 
                          V2 = c(17, 7, 16), 
                          V3 = c(25, 23, 27), 
                          V4 = c(20, 22, 18), 
                          V5 = c(16, 17, 19))


zc <- get_important_cases(test_data)

#task 1.9.7

stat_mode <- function(x){
  x <- table(x)
  as.numeric(names(which(x == max(x))))
  
}

v <- c(1, 2, 3, 3, 3, 4, 5)
z <- stat_mode(v)
z

#task 1.9.8
max_resid <- function(x){
  t <- table(x)
  test <- chisq.test(t)
  result <- as.matrix(test$stdres)
  ind <- (which(result==max(result), arr.ind=T))
  row_names <- rownames(result)[ind[1]]
  col_names <- colnames(result)[ind[2]]
  c(row_names, col_names)
  
}

test_data <- read.csv("https://stepic.org/media/attachments/course/524/test_drugs.csv", stringsAsFactors = T)
#str(test_data)
max_resid(test_data)

#task 2.8.2
get_coefficients <- function(dataset){
 fit <<- glm(y ~ x, dataset, family = 'binomial')
 coef <- as.list(fit$coefficients)
 sapply(coef, exp)
}

test_data <- read.csv("https://stepik.org/media/attachments/course/524/test_data_01.csv")
# переведем переменные в фактор 
test_data <- transform(test_data, x = factor(x), y = factor(y)) 
get_coefficients(test_data)

#task 2.8.3
library(dplyr)
centered <- function(test_data, var_names){
  td <- test_data
  var_names <- sort(var_names)
  td%>%
  mutate_at(vars(var_names), function(x) x - mean(x))
  
}
test_data <- read.csv("https://stepic.org/media/attachments/course/524/cen_data.csv")
var_names = c("X4", "X2", "X1")
centered(test_data, var_names)

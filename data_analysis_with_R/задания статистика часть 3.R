
##task 1.8 VIF

VIF <- function(test_data) {
  
  test <- test_data[-1]
  
  VIF <- numeric(0)
  
  for (i in 1:ncol(test)) {
    fit <- lm(test[,i] ~ as.matrix(test[,-i]), test)
    VIF_test <- 1/(1 - summary(fit)$r.squared)
    VIF <- c(VIF, VIF_test)
    names(VIF)[i] <- names(test)[i] }
  
  return(VIF) }

 a <- VIF(mtcars)
 typeof(a)
#второй вариант
VIF <-  function(test_data){
  test_data = test_data[-1]
  
  sapply(names(test_data), function(name) { i = which(names(test_data)==name); 1/(1-summary(lm(test_data[,i] ~ ., test_data[-i]))$r.squared)})
}

VIF(mtcars)

#task 1.8 smart model
  VIF <- function(test_data) {
    test <- test_data[-1]
    VIF <- numeric(0)
    for (i in 1:ncol(test)) {
      fit <- lm(test[,i] ~ as.matrix(test[,-i]), test)
      VIF_test <- 1/(1 - summary(fit)$r.squared)
      VIF <- c(VIF, VIF_test)
      names(VIF)[i] <- names(test)[i] }
    return(VIF) }

smart_model <-  function(test_data){
  a <- VIF(test_data)
  if(length(a) == 2 & all(a > 10)){
    maxname <- which.max(a[a > 10]) + 1
    test_data <- test_data[-maxname]
    fit <- lm(test_data)
    return(fit$coefficients)}
  
  while(any(a > 10)){
    maxname <- which.max(a[a > 10]) + 1
    test_data <- test_data[-maxname]
    a <- VIF(test_data)
  }
  np <- names(a)
  fit <- lm(test_data)
  return(fit$coefficients)
  
}
test_data <- as.data.frame(list(X1 = c(-0.2, 1.5, 0.9, 0.2, 0.4, 0.3, 0.6, -0.6, -3, -1.8), X2 = c(1.97, -0.69, 0.23, 0.05, -0.66, -1.47, 1.43, -1.86, 0.6, 0.32), X3 = c(1.8, -0.7, 0.3, 0, -0.6, -1.3, 1.6, -1.8, 0.6, 0.4), X4 = c(-0.4, -0.7, -0.7, 0.8, -0.1, -0.8, -0.1, -0.5, -0.9, 0.3), X5 = c(-0.6, 0.4, -0.4, 0.8, -0.6, -0.8, 0.3, 1.3, -0.8, -0.6)))
smart_model(test_data)

#task 2.5.2
library(ggplot2)
exp_data <- read.csv("http://www.bodowinter.com/tutorial/politeness_data.csv")
#exp_data$scenario <- as.factor(exp_data$scenario)
plot_1 <- ggplot(exp_data, aes(x=factor(scenario), y=frequency, fill=attitude))+
                geom_boxplot()
plot_1  

#task 2.5.3
library(ggplot2)
exp_data <- read.csv("http://www.bodowinter.com/tutorial/politeness_data.csv")
plot_2 <- ggplot(exp_data, aes(x=frequency, fill=subject))+
  geom_density(alpha = 0.5)+
  facet_grid(gender ~ .)
plot_2

#task 2.5.4
install.packages("lme4")
library(lme4)
exp_data <- read.csv("http://www.bodowinter.com/tutorial/politeness_data.csv")
fit_1 <- lmer(frequency ~ attitude + (1|subject) + (1|scenario), data = exp_data)
fit_1

#task 2.5.5
library(lme4)
exp_data <- read.csv("http://www.bodowinter.com/tutorial/politeness_data.csv")

fit_2 <- lmer(frequency ~ attitude + gender + (1|subject) + (1|scenario), data = exp_data)
fit_2
summary(fit_2)

#task 2.5.6
library(lme4)
fit_3 <- lmer(frequency ~ attitude + gender + (1 + attittude|subject) + (1 + attittude|scenario), data = exp_data)

#task 3.3.2
median_cl_boot <- function(x){
  m <- matrix(sample(x, size = 10^3*length(x), replace = TRUE), nrow = length(x))
  d   <- apply(m, 2, median)
  quantile(d, c(0.025, 0.975))
}



                   
              


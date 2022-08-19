###задание 1.4 - 13
smart_lm <- function(x){
  
  etap <- apply(x[-1],2, function(y) shapiro.test(y)$p.value) #тест на нормальность всех независимых
  v <- x[,2:ncol(x)]
  v <- v[etap > 0.05] #отбор колонок по условию
  if (length(v) == 0){return("There are no normal variables in the data")}
  x <- cbind(x[1], v) #объединение зависимой переменной и отобранных колонок
  result <- lm(x[[1]] ~ ., x[-1])$coefficients
  return(result)
  
}

smart_lm(swiss)

test_data <- read.csv("https://stepik.org/media/attachments/course/724/test.csv")
smart_lm(test_data)



###задание 1.4 - 14
one_sample_t <- function(test_data, general_mean){
  num <<- test_data[sapply(test_data, is.numeric)] #выбор числовых колонок
  l <- lapply(num, function(x) t.test(x, mu = general_mean))
  res <- lapply(l, function(x) c(x$statistic, x$parameter,x$p.value))
  return(res)
}

one_sample_t(iris[, 1:4], 4)

###задание 1.4 - 15
normality_tests <- lapply(iris[, 1:4], shapiro.test)
get_p_value <- function(test_list){
  res <- lapply(test_list, function(x) x$p.value)
  return(res)
}

get_p_value(normality_tests)

###задание 1.5  10
library(ggplot2)
library(dplyr)
end <- nrow(diamonds)

d <- slice(diamonds, seq(1, nrow(diamonds), by = 2))

####задание  1.5  12
library(dplyr)
my_df <- mtcars %>%
  select(mpg, hp, am, vs) %>%
  filter(mpg > 14, hp > 100) %>%
  arrange(desc(mpg)) %>%
  slice(1:10) %>%
  rename(`Miles per gallon` = mpg, `Gross horsepower` = hp)
           
###задание 1.6 4


library(dplyr)
log_transform <- function(test_data){
  test_data %>%
  mutate_if(is.numeric, funs((.- min(.))/(max(.) - min(.)) + 1))%>% 
  mutate_if(is.numeric, funs(log))

}

test_data <- as.data.frame(list(V1= c(1.5, -0.1, 2.5, -0.3, -0.8),
                                V2= c(-0.9, -0.3, -2.4, 0.0,  0.4),
                                V3= c(-2.8, -3.1, -1.8, 2.1, 1.9),
                                V4 =c('A', 'B', 'B', 'B', 'B')))
log_transform(test_data)

## задание 1.6 13
library(dplyr)
descriptive_stats <- function (dataset){
  dataset %>%
    group_by(gender, country) %>%
    summarise(n = n(),
              mean = mean(salary, na.rm = T),
              sd = sd(salary, na.rm = T), 
              median = median(salary, na.rm = T),
              first_quartile = quantile(salary, 0.25, na.rm = T),
              third_quartile = quantile(salary, 0.75, na.rm = T),
              na_values = sum(is.na(salary)))
  
  
}
test_data <- read.csv("https://stepic.org/media/attachments/course/724/salary.csv")
descriptive_stats(test_data)

## задание 1.6 15
library(dplyr)
to_factors <- function(test_data, factors){
  test_data <- mutate_at(test_data, vars(factors), funs(ifelse(. > mean(.), 1, 0)))
  test_data <<- mutate_at(test_data, vars(factors), funs(as.factor))
  test_data
}
to_factors(mtcars[1:4], factors = c(1, 3))

###задание 1.6 16
library(dplyr)
library(ggplot2)
high_price <- diamonds %>%
  select(color, price) %>%
  arrange(color, desc(price)) %>%
  group_by(color) %>%
  slice(1:10)
high_price

##задание 1.7 9
filter.expensive.available <- function(products, brands) {
  products[(price >= 5000*100) & (brand %in% brands) & (available == TRUE)]
}

##задание 1.7 10
library(data.table)
ordered.short.purchase.data <- function(purchases) {
  p <- purchases[order(price, decreasing = TRUE)]
  p <- p[quantity > 0]
  p <- p[ , .(ordernumber, product_id)]
  p
}

sample.purchases <- data.table(price = c(100000, 6000, 7000, 5000000),
                               ordernumber = 1:4,
                               quantity = c(1,2,1,-1),
                               product_id = 1:4)
ordered.short.purchase.data(sample.purchases)

##задание 1.7 11
library(data.table)
purchases.median.order.price <- function(purchases) {
  purchases[quantity > 0][ , .(sum(price * quantity)), by = ordernumber][, median(V1)]
  
}

sample.purchases <- data.table(price = c(100000, 6000, 7000, 5000000),
                               ordernumber = c(1,2,2,3),
                               quantity = c(1,2,1,-1),
                               product_id = 1:4)
purchases.median.order.price(sample.purchases)

##задание 1.8 7
library(data.table)
get.category.ratings <- function(purchases, product.category) {
  setkey(purchases, product_id)
  setkey(product.category, product_id)
  t <- merge(purchases, product.category, by = "product_id")
  t[, .(totalcents = sum(totalcents), quantity = sum(quantity)), by = category_id]
}

product.category <- data.table(product_id = c(1,1,2,2,3),
                               category_id = c(1,2,1,3,3))
purchases <- data.table(product_id = c(1, 2, 3),
                        totalcents = c(100, 200, 300),
                        quantity = c(1, 1, 3))
get.category.ratings(purchases, product.category)

##задание 1.8 8
library(data.table)
mark.position.portion <- function(purchases) {
  
  purchases[quantity > 0, 'price.portion' := formatC(round((price*quantity)/sum(price*quantity)*100,2), format='f', digits=2), by = ordernumber][quantity > 0]

}

sample.purchases <- data.table(price = c(100, 300, 50, 700, 30),
                               ordernumber = c(1,1,1,2,3),
                               quantity = c(1,1,2,1,-1),
                               product_id = 1:5)
mark.position.portion(sample.purchases)


##задача 2.1 6
library(ggplot2)
diamonds
depth_hist <- qplot(x = depth, data = diamonds)
depth_hist
##задача 2.1 9
library(ggplot2)
price_carat_clarity_points <- qplot(x = carat, y = price, color = clarity, data = diamonds)
price_carat_clarity_points

##задача 2.1 11
library(ggplot2)

x_density <- qplot(x = x,
                  data = diamonds,
                  col = I("black"),
                  geom = "density")
x_density

##задача 2.1 12
library(ggplot2)
x_cut_density <- qplot(x = x, data = diamonds, geom = 'density', color = cut)
x_cut_density

##задача 2.1 13
library(ggplot2)
price_violin <- qplot(x = color,
                      y = price,
                      data = diamonds,
                      geom = 'violin')
price_violin


###задача 2.2 7
library(ggplot2) 
my_plot <- ggplot(mtcars, aes(factor(am), mpg))+
  geom_violin()+
  geom_boxplot(width = 0.2)

my_plot

###задача 2.2 9
library(ggplot2)
sales <- read.csv("https://stepic.org/media/attachments/course/724/sales.csv", encoding="UTF-8")
my_plot <- ggplot(sales, aes(income, sale))+
  geom_point(aes(color = shop))+
  geom_smooth(method = "lm")

my_plot

###задача 2.2 10
library(ggplot2)
sales <- read.csv("https://stepic.org/media/attachments/course/724/sales.csv", encoding="UTF-8")
my_plot <- ggplot(sales, aes(shop, income, col = factor(season)))+
  stat_summary(fun.data = mean_cl_boot, geom = "pointrange", position = position_dodge(0.2))

my_plot

###задача 2.2 11
library(ggplot2)
sales <- read.csv("https://stepic.org/media/attachments/course/724/sales.csv", encoding="UTF-8")
my_plot <-  ggplot(sales, aes(date, sale, col = factor(shop), group = factor(shop)))+
  stat_summary(fun.data = mean_cl_boot, geom = 'errorbar', position = position_dodge(0.2)) + # добавим стандартную ошибку
  stat_summary(fun.data = mean_cl_boot, geom = 'point', position = position_dodge(0.2)) + # добавим точки
  stat_summary(fun.data = mean_cl_boot, geom = 'line', position = position_dodge(0.2)) # соединим линиями

my_plot

###задача 2.3 7
library(ggplot2)
mpg_facet <- ggplot(mtcars, aes(mpg))+
  geom_dotplot()+
  facet_grid(am ~ vs)

mpg_facet

###задача 2.3 8
library(ggplot2)
sl_wrap <- ggplot(iris, aes(Sepal.Length))+
  geom_density()+
  facet_wrap(~ Species)

sl_wrap

###задача 2.3 9
library(ggplot2)
my_plot <- ggplot(iris, aes(Sepal.Length, Sepal.Width))+
  geom_point()+
  geom_smooth()+
  facet_wrap(~ Species)

my_plot

###задача 2.3 10
library(ggplot2)
myMovieData <- read.csv("myMovieData.csv")

my_plot <- ggplot(myMovieData, aes(Type, Budget)) +
  geom_boxplot()+
  facet_grid(.~ Year)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

my_plot  

###задача 2.4 6
library(ggplot2)
iris_plot <- ggplot(iris, aes(Sepal.Length, Petal.Length, col = Species))+
  geom_point() +
  geom_smooth(method = "lm")+
  scale_color_discrete(name = 'Вид цветка', 
                       labels = c('Ирис щетинистый', "Ирис разноцветный", "Ирис виргинский"))+
  scale_x_continuous(name = "Длина чашелистика", 
                     breaks = seq(4,8,1),
                     limits = c(4,8))+ 
  scale_y_continuous(name = "Длина лепестка",
                     breaks = seq(1,7,1))

iris_plot

###задача 2.6 7
library(plotly)

make.fancy.teapot <- function(teapot.coords) {
  i.s <- seq(0, (nrow(teapot.coords)-1), 3)
  j.s <- seq(1, nrow(teapot.coords), 3)
  k.s <- seq(2, nrow(teapot.coords), 3)
  plot_ly(df, x = ~x, y = ~y, z = ~z, i = ~i.s, j = ~j.s, k = ~k.s, type = "mesh3d", 
          alphahull = 0)
}


df <- fread('teapot.csv')
make.fancy.teapot(df)


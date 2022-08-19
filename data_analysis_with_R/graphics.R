#боксплоты
df <- na.omit(airquality)
df$Month <- factor(df$Month)
library("ggplot2")
a <- ggplot(df, aes(x = Month, y = Ozone))+
 geom_boxplot()
a

#скаттерплот
plot1 <- ggplot(mtcars, aes(x = mpg, y = disp, col = hp))+
  geom_point()
plot1  

#рассеивание
ggplot(iris, aes(Sepal.Length, Sepal.Width, col = Species, size = Petal.Length)) +
  
  geom_point()
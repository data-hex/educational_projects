#импорт данных
avian <- read.csv("https://raw.githubusercontent.com/tonytonov/Rcourse/master/R%20programming/avianHabitat.csv")
avian$Observer <- as.factor(avian$Observer)

#using dplyr
library(stringr)
library(dplyr)
options(stringsAsFactors = FALSE) 
# First approach
avian <- read.csv("avianHabitat.csv")

avian <- subset(avian, PDB > 0 & DBHt > 0, c("Site", "Observer", "PDB", "DBHt"))
avian$Site <- factor(str_replace(avian$Site, "[:digit:]+", ""))
subset(
  aggregate(avian$DBHt, list(Site = avian$Site, Observer = avian$Observer), max),
  x >= 5
)

# Second approach (using pipes)
avian <- read.csv("avianHabitat.csv")

avian <-
  avian %>% 
  subset(PDB > 0 & DBHt > 0, c("Site", "Observer", "PDB", "DBHt")) %>% 
  transform(Site = factor(str_replace(.$Site, "[:digit:]+", "")))

aggregate(avian$DBHt, list(Site = avian$Site, Observer = avian$Observer), max) %>% 
  subset(x >= 5)

# Third approach (using both pipes and dplyr)
avian <- read.csv("avianHabitat.csv")

avian %>% 
  filter(PDB > 0, DBHt > 0) %>% 
  select(Site, Observer, contains("DB")) %>% 
  mutate(Site = factor(str_replace(Site, "[:digit:]+", ""))) %>% 
  group_by(Site, Observer) %>% 
  summarise(MaxHt = max(DBHt)) %>% 
  filter(MaxHt >= 5) 


#проверка данных
str(avian)
head(avian)
tail(avian)
summary(avian)
any(!complete.cases(avian)) #проверка пропущенных значений
any(avian$PDB < 0) #проверка столбца на отрицательные значени€
any(avian$PDB > 100) #проверка столбца на значени€ больше 100 процентов

#функци€ дл€ проверки целых столбцов на содержание отрицательных чисел  чисел больше 100%, в x вставл€ем столбец, к примеру avian$PDB
check_percent_range <- function(x) {
  any(x < 0 | x > 100)
}

check_percent_range(avian$PB) #пример работы функции

#проверка дл€ массовой проверки столбцов

library(stringr) #подключение библиотеки дл€ работы с регул€рками
coverage_variables <- names(avian)[str_detect(names(avian), "^P")] #выборка имен по шаблону
sapply(coverage_variables, function(name) check_percent_range(avian[[name]])) #функци€ массовой проверки столбцов

names(avian) #имена переменных
#coverage_variables <- names(avian)[-(1:4)][c(T,F)] #выбор столбцов, кроме с 1 по 4 и дальше через один
coverage_variables
avian$total_coverage <- rowSums(avian[,coverage_variables]) #создаем новый столбец с суммами по нужным столбцами по строкам
summary(avian$total_coverage) #оцениваем разброс новой переменной

#задание на соединение файлов в датафрейм с пересчетом значений
avian1 <- read.csv("https://raw.githubusercontent.com/tonytonov/Rcourse/master/R%20programming/avianHabitat.csv")
avian2 <- read.csv("https://raw.githubusercontent.com/tonytonov/Rcourse/master/R%20programming/avianHabitat2.csv", sep = ';', skip = 5, comment.char = c("%"), na.strings = c("Don't remember"))
library(dplyr)
avian3 <- bind_rows(avian1, avian2)
names(avian3)
coverage_variables <- names(avian3)[-(1:4)][c(T,F)]
avian3$total_coverage <- rowSums(avian3[,coverage_variables])
summary(avian3$total_coverage)

#вычлен€ем регул€ркой гео без конкретного местоположени€ и сохран€ем в отдельную переменную
avian$site_name <- factor(str_replace(avian$Site, "[:digit:]+", ""))
#подсчет среднего по гео
tapply(avian$DBHt, avian$site_name, mean)
#задача на наименьшее среднее общее покрытие
which.min(tapply(avian$total_coverage, avian$site_name, mean))
#задача  на самые высокие виды по наблюдател€м
which.max(tapply(avian$L, avian$Observer, max))






#������ ������
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


#�������� ������
str(avian)
head(avian)
tail(avian)
summary(avian)
any(!complete.cases(avian)) #�������� ����������� ��������
any(avian$PDB < 0) #�������� ������� �� ������������� ��������
any(avian$PDB > 100) #�������� ������� �� �������� ������ 100 ���������

#������� ��� �������� ����� �������� �� ���������� ������������� �����  ����� ������ 100%, � x ��������� �������, � ������� avian$PDB
check_percent_range <- function(x) {
  any(x < 0 | x > 100)
}

check_percent_range(avian$PB) #������ ������ �������

#�������� ��� �������� �������� ��������

library(stringr) #����������� ���������� ��� ������ � �����������
coverage_variables <- names(avian)[str_detect(names(avian), "^P")] #������� ���� �� �������
sapply(coverage_variables, function(name) check_percent_range(avian[[name]])) #������� �������� �������� ��������

names(avian) #����� ����������
#coverage_variables <- names(avian)[-(1:4)][c(T,F)] #����� ��������, ����� � 1 �� 4 � ������ ����� ����
coverage_variables
avian$total_coverage <- rowSums(avian[,coverage_variables]) #������� ����� ������� � ������� �� ������ ��������� �� �������
summary(avian$total_coverage) #��������� ������� ����� ����������

#������� �� ���������� ������ � ��������� � ���������� ��������
avian1 <- read.csv("https://raw.githubusercontent.com/tonytonov/Rcourse/master/R%20programming/avianHabitat.csv")
avian2 <- read.csv("https://raw.githubusercontent.com/tonytonov/Rcourse/master/R%20programming/avianHabitat2.csv", sep = ';', skip = 5, comment.char = c("%"), na.strings = c("Don't remember"))
library(dplyr)
avian3 <- bind_rows(avian1, avian2)
names(avian3)
coverage_variables <- names(avian3)[-(1:4)][c(T,F)]
avian3$total_coverage <- rowSums(avian3[,coverage_variables])
summary(avian3$total_coverage)

#��������� ���������� ��� ��� ����������� �������������� � ��������� � ��������� ����������
avian$site_name <- factor(str_replace(avian$Site, "[:digit:]+", ""))
#������� �������� �� ���
tapply(avian$DBHt, avian$site_name, mean)
#������ �� ���������� ������� ����� ��������
which.min(tapply(avian$total_coverage, avian$site_name, mean))
#������  �� ����� ������� ���� �� ������������
which.max(tapply(avian$L, avian$Observer, max))






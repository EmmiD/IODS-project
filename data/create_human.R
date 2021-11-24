# I read datas "Human development" and "Gender inequality" into R

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

hd
gii

str(hd)
dim(hd)
str(gii)
dim(gii)

#Summaries of the variables

summary(hd)
summary(gii)

#Renaming of the variables

colnames(hd)
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "life_exp"
colnames(hd)[5] <- "exp_edu"
colnames(hd)[6] <- "mean_edu"
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI.rank-HDI.Rank"
colnames(hd)

colnames(gii)
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "mat_mort"
colnames(gii)[5] <- "adol_birth"
colnames(gii)[6] <- "%_in_parl"
colnames(gii)[7] <- "sec_edu_female"
colnames(gii)[8] <- "sec_edu_male"
colnames(gii)[9] <- "labour_force_female"
colnames(gii)[10] <- "labour_force_male"
colnames(gii)

#I create 2 new variables

library(dplyr)
library(ggplot2)

# Variable 1: the ratio of female and male populations with secondary education

gii <- mutate(gii, edu_ratio = (sec_edu_female / sec_edu_male))

# Variable 2: the ratio of labour force participation of females and males

gii <- mutate(gii, labour_ratio = (labour_force_female / labour_force_male))

colnames(gii)

# I join datasets gii and hd

join_by <- c("Country")

human <- inner_join(hd, gii, by = join_by, suffix = c(".math", ".por"))

dim(human)

#..and save it to my data folder

write.csv(human,file="~/IODS-project/data/human.csv")

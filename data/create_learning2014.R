#Emmi Danner 9.11.2021
#This file includes the data for the week 2

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = TRUE)

str(learning2014)
dim(learning2014)

#This data consists of 60 variables and 183 observations/variable.

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

library(dplyr)

deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points" )

lrn14 <- select(learning2014, one_of(keep_columns))

lrn14 <- filter(lrn14, Points > 0)

dim(lrn14)

# lrn14 have now 166 observations and 7 variables

write.csv(lrn14, file = 'data/learning2014')

str(read.csv(file = "data/learning2014"))
head(read.csv(file = "data/learning2014"))

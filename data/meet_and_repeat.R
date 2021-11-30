# I load and read data sets BPRS and RATS into R

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t", header = TRUE)

BPRS
RATS

colnames(BPRS)
str(BPRS)
summary(BPRS)
glimpse(BPRS)

#In BPRS data set, there are 40 subjects, 20 in each two treatment groups. Brief psychiatric rating scale (BPRS) was measured before the treatment started and weekly after that for eight weeks. In this **wide form data**, each subject has one row and the weekly measurents are in columns.

colnames(RATS)
str(RATS)
summary(RATS)
glimpse(RATS)

#In RATS data set, there are 16 rats divided in 3 different groups (different diets). The weight of each rat was recorded 11 times during a 9-week period. In this **wide form data", each rat has an own row and all the weight measurements are in columns.

# I convert the categorical variables to factors

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# I convert the data sets to long form and add a week variable to BPRS and a time variable to RATS.
library(dplyr)
library(tidyr)

BPRSL <-  BPRS %>% 
  gather(key = weeks, value = bprs, -treatment, -subject) %>%
  mutate(week = as.integer(substr(weeks,5,5)))


RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))

#I explore these new **long form data** sets.

colnames(BPRSL)
str(BPRSL)
summary(BPRSL)
glimpse(BPRSL)

colnames(RATSL)
str(RATSL)
summary(RATSL)
glimpse(RATSL)


#In the long form data sets, every measurement has an own row, instead of subjects. Subject, treatment/diet groupa and the time of the measurement are in the columns.

write.csv(BPRSL,file="~/IODS-project/data/BPRSL.csv")
write.csv(RATSL,file="~/IODS-project/data/RATSL.csv")

#Emmi Danner 19.11.2021
#This file includes the data for the week 3

# I read both tables into R and explore the structure and dimensions

por <- read.table("student-por.csv", sep = ";", header=TRUE)
math <- read.table("student-mat.csv", sep = ";", header=TRUE)

str(por)
dim(por)

str(math)
dim(math)

# Define own id for both datasets
library(dplyr)
por_id <- por %>% mutate(id=1000+row_number()) 
math_id <- math %>% mutate(id=2000+row_number())

# Which columns vary in datasets
free_cols <- c("id","failures","paid","absences","G1","G2","G3")


# The rest of the columns are common identifiers used for joining the datasets
join_cols <- setdiff(colnames(por_id),free_cols)

pormath_free <- por_id %>% bind_rows(math_id) %>% select(one_of(free_cols))

# Combine datasets to one long data
pormath <- por_id %>% 
  bind_rows(math_id) %>%

  # Aggregate data (more joining variables than in the example)  
  group_by(.dots=join_cols) %>%  
  # Calculating required variables from two obs  
  summarise(                                                           
    n=n(),
    id.p=min(id),
    id.m=max(id),
    failures=round(mean(failures)),     
    paid=first(paid),                   
    absences=round(mean(absences)),
    G1=round(mean(G1)),
    G2=round(mean(G2)),
    G3=round(mean(G3))    
  ) %>%
  
  # Remove lines that do not have exactly one obs from both datasets
 
  filter(n==2, id.m-id.p>650) %>%  
  # Join original free fields
  inner_join(pormath_free,by=c("id.p"="id"),suffix=c("",".p")) %>%
  inner_join(pormath_free,by=c("id.m"="id"),suffix=c("",".m")) %>%
  


  
  # Calculate other required variables  
  ungroup %>% mutate(
    alc_use = (Dalc + Walc) / 2,
    high_use = alc_use > 2,
    cid=3000+row_number()
  )

# I check the data to see if everything is ok.

glimpse(pormath)

# Save created data to folder 'data'
write.csv(pormath,file="~/IODS-project/data/pormath.csv")

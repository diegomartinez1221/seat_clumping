library(tidyverse)
library(reprex)
library(ggplot2)

vector<- (1:30)
genders<- c(rep("M",14),rep("F",16))
x<-data.frame(vector, genders, sample(1:30,30,replace=F))
colnames(x) <- c("student", "genders", "seat")


x<-x %>%
  mutate(table = ceiling(seat/4)) %>%
  group_by(table) %>%
  count(genders) %>%
  filter(table != 8) %>% 
  filter(genders == "M" & n == 2) %>% 
  nrow()

n_sims <- 1000
n_tables <- rep(NA, n_sims)

for (s in 1:n_sims){
  
  vector<- (1:30)
  genders<- c(rep("M",14),rep("F",16))
  x<-data.frame(vector, genders, sample(1:30,30,replace=F))
  colnames(x) <- c("student", "genders", "seat")

  x<-x %>%
    mutate(table = ceiling(seat/4)) %>%
    group_by(table) %>%
    count(genders) %>%
    filter(table != 8) %>% 
    filter(genders == "M" & n == 2) %>% 
    nrow()
  
    n_tables[s] = x
}

hist(n_tables)

n_tables_graph = as.data.frame(n_tables)

n_tables_graph %>% 
  ggplot() + 
  geom_histogram(aes(x = n_tables), bins = 8) + 
  labs(title = "Simulated Distribution of Even Tables",
       subtitle = "Red = Simulated Mean, Blue = Observed Mean",
       caption = "David Kane, Gov 1006, February 12") +
  
  geom_vline(aes(xintercept = mean(n_tables)), color = "red", linetype = "dashed", size = .5) +
               
  geom_vline(aes(xintercept = 2), color = "blue", linetype = "dashed", size = .5)






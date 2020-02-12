vector<- (1:30)
genders<- c(rep("M",14),rep("F",16))
x<-data.frame(vector, genders, sample(1:30,30,replace=F))
colnames(x) <- c("student", "genders", "seat")


x<-x %>%
  mutate(table = floor(seat/4 + 1)) %>%
  group_by(table) %>%
  count(genders) %>%
  filter()

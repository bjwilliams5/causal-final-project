

popest <- read_csv("popest.csv")

popest_revised <- popest %>%
  select(!Fips) %>%
  pivot_longer(!Area, names_to = "Year", values_to = "Pop")

my_data <- read.delim("us.1990_2020.19ages.adjusted.txt", header = FALSE)

my_data <- my_data %>% 
  transform(year = substr(V1, 1,4), state = substr(V1, 5, 6), fips = substr(V1, 7, 8), 
            cfips = substr(V1, 9, 11), reg = substr(V1, 12, 13),  race = substr(V1, 14, 14),
            hisp = substr(V1, 15, 15), sex = substr(V1, 16, 16),  age = substr(V1, 17, 18),
            pop = substr(V1, 19, 26))

my_data <- as.data.frame(my_data)0
my_data$age <- as.numeric(my_data$age)
my_data$pop <- as.numeric(my_data$pop)
my_data$race <- as.numeric(my_data$race)
my_data$hisp <- as.numeric(my_data$hisp)
my_data$sex <- as.numeric(my_data$sex)


my_data <- my_data %>% 
  select(!c("V1", "cfips", "reg"))


df <- my_data %>%
  pivot_longer(!c(year, state, fips), names_to = "Year", values_to = "Pop")

df <- my_data %>%
  group_by(year, state, fips, race, sex, hisp) %>% 
  summarize(population = sum(pop))
  
  
  
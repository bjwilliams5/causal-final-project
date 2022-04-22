

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

my_data <- my_data %>% 
  select(!c("V1", "cfips", "reg")) %>% 
  mutate(agegroup = case_when(
    
  ))

my_data$pop <- as.numeric(my_data$pop)

df <- my_data %>%
  group_by(year, state, fips, race, sex, hisp) %>% 
  summarize(population = sum(pop))
  
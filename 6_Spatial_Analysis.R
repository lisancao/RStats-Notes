#Case study: TB Map - comment this code 
tb <- read_csv("tb.csv") %>% # read in data 
  select(-new_sp, -contains("04"), -contains("514"), 
         -new_sp_mu, -new_sp_fu) %>% #exclude these variables 
  gather(new_sp_m014:new_sp_f65, # make these row values, mapped to demographics 
         key = demog, 
         value = count, # set value 
         na.rm = TRUE) %>%  # make na values implicit/remove them 
  mutate(demog = substr(demog, 8, 12)) %>% # add new variable column, substringing demog, start at 8th element and end at 12th 
  separate(demog, into = c("gender", "agecat"), sep = 1) # separate demographic columns into "gender" and "agecat", using 1 as the divider 

tb2 <- tb %>% # take previous data 
  spread(key = gender, value = count) %>%  # make new columns based on gender values 
  mutate(count = m + f) %>% # add new column called count, that adds male and female columns together 
  select(-m, -f) %>% # exclude m and f columns 
  filter(!is.na(iso2)) #view rows with NAs in the iso2 column 

# making a map 
# use map data from maps 
library(maps)

ww <- as_tibble(map_data("world")) %>%  # load in map data as tibble 
  mutate(iso2 = iso.alpha(region)) # create new column of iso code of each region
ww

# TB 
tbchild00 <- tb %>% # use tb data 
  filter(agecat == "014", year == 2000) %>% # filter rows where agecat = 014, and in the year 2000
  select(iso2, count) #select isocodes and count columns only 
tbchild00

wwchild00 <- ww %>% # use ww data 
  left_join(tbchild00) # left_join on ww 
wwchild00

# make map plot 
ggplot(wwchild00, 
       aes(x=long, y=lat, fill=log(count+1), #tranform to log count as count scale is not able to distinguish countries, as well as use log of count + 1 to avoid log = 0
       group=group)) + 
  geom_polygon() + # use geom_polygon
  coord_quickmap() 

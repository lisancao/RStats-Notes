#load libraries 
library(rvest)
library(tibble)

#box office scrape

box_weekly = function() {
  movie_table = read_html("https://www.imdb.com/chart/boxoffice")
  html_table = html_table(html_node(movie_table, "table")) 
  gross = as.numeric(gsub("[$, M]", "", html_table$Gross))
  gross_week = gross/html_table$Weeks
  movie_table = tibble(Name = html_table$Title, PerWeek = paste(gross_week, "M"))
  return(movie_table)
}


## With some added conditions: 
# modify the function you wrote in the first part of this question to add a column named rt 
# contained the rating recieved on rotten tomatoes,
# must construct url 
# Onward is returned in the IMDB boxoffice page with title Onward (i.e., with a capital O) and the corresponding rotten tomatoes website is https://www.rottentomatoes.com/m/onward/ with a lower case o
# Bonus points will be awarded for exceptionally large coverage.

## Gameplan
#Steps: 
# 1: extract value from name col
# 2: sub spaces and special characters to underscores 
# 3: convert to lower case
# 4: paste into rotten tomatoes url https://www.rottentomatoes.com/m/
# 5: extract scores via html node (convert to numeric?) 
# 6: paste in as column to movie_table 

# #for loop for each movie name 
# #grep functions 
# #retrieve with another for loop
# #paste into new column 
# #paste into data frame 


box_weekly_RT = function() {
  movie_table = read_html("https://www.imdb.com/chart/boxoffice")
  html_table = html_table(html_node(movie_table, "table")) 
  gross = as.numeric(gsub("[$, M]", "", html_table$Gross))
  gross_week = gross/html_table$Weeks
  movie_table = tibble(Name = html_table$Title, PerWeek = paste(gross_week, "M"))
  
  movie_table$RT = 0
  i = 0
  
  for(row in 1:nrow(movie_table)) { 
    mov_clean = gsub("[[:punct:]]|\\s", "_", movie_table$Name) %>% 
      gsub("[[:punct:]]?$","", .) %>%
      tolower()
    
    rt_url = paste0("https://www.rottentomatoes.com/m/", mov_clean[i], sep = "")
    
    tomatoes_score = read_html(rt_url) %>% 
      html_node("#tomato_meter_link > span:nth-child(2)") %>% 
      html_text() %>% 
      trimws(tomatoes_score, "[ \t\r\n]")
    
    movie_table$RT[i] = tomatoes_score
    
    i = i + 1
  }
  
  movie_table_RT = tibble(Name = html_table$Title, PerWeek = paste(gross_week, "M"), RT = movie_table$RT)
  return(movie_table_RT)
}



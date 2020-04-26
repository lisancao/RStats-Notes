
# load libraries 
library(RCurl)
library(stringr)
library(dplyr)
library(rvest)
library(stringr)
library(jsonlite)
library(rjson)
library(htmlParse)

# Download an URL and extract a heading using regex 

url <- "https://www.sfu.ca/outlines.html?2020/spring/stat/240/d100"
url_read <- readLines(url)
url_clean <- trimws(url_read) 
heading_3 <- grep('<h3', url_clean, value = TRUE)
gsub('*."> | </.*', "", heading_3)

# cleaned up and used in a pipe using Rvest
course_info = sfu_link %>% 
  read_html() %>% 
  html_nodes("h3") %>% 
  html_text() %>% 
  as.character()



############################################################## QUESTION 1:B
# Extract the course code from the text of the web-site https://www.sfu.ca/outlines.html?2020/spring/stat/240/d100, and provide the R code. Argue that the same code works on the pages for the outlines of other courses (or, modify that your code so that it does).

sfu_link1 = "https://www.sfu.ca/outlines.html?2020/summer/apma/995/g100"
sfu_link2 = "https://www.sfu.ca/outlines.html?2020/summer/bisc/202/c100"

#has prof
sfu_link3 = "https://www.sfu.ca/outlines.html?2020/spring/stat/203/d100"

num_pattern = "(\\d)+"

course_number = sfu_link2 %>% 
  read_html() %>% 
  html_nodes("#class-number") %>% 
  html_text() %>% 
  str_extract(., num_pattern) %>% 
  as.numeric()

# Extract certain elements 
course_number = sfu_link2 %>% 
  read_html() %>% 
  html_nodes("#class-number") %>% 
  html_text() %>% 
  str_extract(., num_pattern) %>% 
  as.numeric()
course_number

course_name = sfu_link2 %>% 
  read_html() %>% 
  html_nodes("#title") %>% 
  html_text() %>% 
  str_replace_all(., "[^[:alpha:]]", "") %>%
  as.character()
course_name

prof_name = "\\s(.*)\\s"

grep("/(.*/h4>\\s+)(.*)(\\s+<br.*)/", url_read)

course_prof = sfu_link3 %>%
  read_html() %>% 
  html_node(".instructorBlock1") %>% 
  html_text() %>%
  str_replace_all(., "[^[:alpha:]]", "") %>%
  gsub("Instructor|sfuca", "", .)
#str_match(., "Instructor(.*?)sfuca") 

course_output <- list(course = course_number, instructor = course_prof)

##################### FUNCTION 

# as three functions 

instructor1 = function(html) { 
  html_text(html_node(html, ".instructorBlock1")) %>%
    strsplit(., "\n") 
  instructor = trimws(instructor[[1]][3])
}

course1 = function(html) { 
  num_pattern = "(\\d)+"
  html_text(html_nodes(html, "#class-number")) %>%
    str_extract(., num_pattern) %>% 
    as.numeric()
}

course_scrape1 = function(link) { 
  html = read_html(link)
  course = course1(html)
  instructor = instructor1(html)
  output = list(course = course1, instructor = instructor1)
  return(output)
}

course_scrape1(sfu_link3)

#consolidate into one function 

sfu_link1 = "https://www.sfu.ca/outlines.html?2020/summer/apma/995/g100"
sfu_link2 = "https://www.sfu.ca/outlines.html?2020/summer/bisc/202/c100"
# has prof
sfu_link = "https://www.sfu.ca/outlines.html?2020/spring/stat/240/d100"
sfu_link3 = "https://www.sfu.ca/outlines.html?2020/spring/stat/203/d100"

#### as one function 
course_scrape = function(link) { 
  html = read_html(link)
  num_pattern = "(\\d)+"
  course = html_text(html_nodes(html, "#class-number")) 
  course = str_extract(course, num_pattern)
  instructor = html_text(html_node(html, ".instructorBlock1")) 
  instructor = strsplit(instructor, "\n")
  instructor = trimws(instructor[[1]][3])
  output = list(course = as.numeric(course), instructor = instructor)
  return(output)
}

course_scrape(sfu_link2)


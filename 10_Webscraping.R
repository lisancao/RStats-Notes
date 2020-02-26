
# using rvest 
library(rvest)
library(dplyr)


pitchfork_url <- "https://pitchfork.com/reviews/albums/destroyer-have-we-met/"


#get rating 
rating = pitchfork_url %>% 
  read_html() %>%
  html_nodes(".score") %>% 
  html_text()

#import rating as numeric 
rating = as.numeric(rating)

#get review 
review = pitchfork_url %>% 
  read_html() %>% 
  html_nodes(".contents") %>% 
  html_text()

#clean review 
gsub("[\r\n]", "", review)

#messy ways: stringr and regex 
# INCOMPLETE 
library(RCurl)
library(stringr)
library(dplyr)
library(rvest)

url = "https://pitchfork.com/reviews/albums/destroyer-have-we-met/"

review = getURL(url)
cat(review, file = "review.txt")
review = file("review.txt")

review.char = readChar(review, file.info("review.txt")$size) %>% 
  trimws(review) %>%
  strsplit(review)
gsub('.*[<div class="contents dropcap">] | \\[<a class="end-mark-container" href="/">].*',"", review.char) %>% 
  str


#########################################################

# BASE R regex 
# adapted from Lloyd Elliot course materials 

#########################################################

# search functions 
grep()  #input a vector or list, output indices of elements with the pattern 


grepl() #l=logical that returns TRUE/FALSE

# extract 
gregexpr() #input a vector or list of text, output a list showing text start position and pattern length 

substr() # subset a string of text, input is a string of text, output is the elements from start to stop 

regmatches() #takes beginning and end and then extract string 

# replace 
gsub() 


## with stringr 
library(stringr)

#search 
str_detect()

# extract 
str_extract() 
str_extract_all()

#replace 
str_replace()
str_replace_all()


### formal regular expressions 
# concatenation <empty string> , matches a string of characters and taken as literal 
grep("ALSJDALSD") 

# Or | 
grep("aksljd | aLAKJ")

# closure * 
grep("AB*A")

# parentheses ()
grep("(AB)*A")


#### general pieces in R, must use \ 
# view more here: https://cran.r-project.org/web/packages/stringr/vignettes/regular-expressions.html
# space characters \s 
# no space characters \S
# end of string $ 
# beginning of string ^ 
# word characters aka groups \w 
# non word characters \W 
# digits \d 
# non digits \D 
# word edge \b 
# non word edge \B 
# word beginning \< 
# word end \> 

### extended & shorthands 
# optional ? 
grep("AB?")
# non greedy *? 
grep("AB*?A")
# one or more +
grep("AB+A")
# parentheses [ ]
grep("[abcd]e")
# wildcard . 
grep(".*ABSD.*")

### other methods to load in string 
scan() 

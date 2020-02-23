###################################################

## CONTROL FLOW ##
#adapted from Learning R 

#################################################### IF STATEMENTS
# conditional execution using a logical vector of length one
# if(NA), aka missing values are not allowed to be passed and will return an error, instead use if(is.na(NA)) to test for missing values 

# Boolean examples: 
if(TRUE) message("Valid entry")
if(FALSE) message("Invalid entry")
if(NA) message("NA detected") 
if(is.na(NA)) message("NA detected")


# Variable and expression examples: 
# using runif() for randomization 
if (runif(1) > 0.5 ) message ("This message appears with a 50% chance")

# using a simply expression 
a = 6
if(a > 4) { 
  b = 2 * a
  c = 3 * b } #curly brackets for code clarity 
print(c(a, b, c))

# use an else statement in the case of FALSE condition 
a = 3
if(a > 4) { 
  b = 2 * a
  c = 3 * b } else { #must be on the same line as closing if curly bracket 
    message("it was less than 4!") }

# using else if 
n = "hellow"
if(is.numeric(n)) { 
  message("thats a number") 
} else if (is.character(n)) { 
  message("that's a character!") 
} else if (is.data.frame(n)){ 
  message("that's a data frame!") 
} else { 
  message("Actually, I'm not quite sure what that is") } 

# using conditional assignment using a real vs imaginary component 
print(if(Re(a) == 3) "real" else "imaginary")

# using ifelse for vectorized flow control
# ifelse takes 3 arguments: (logical vector of condition),(returned values when first vector = TRUE), (returned values when first vector = FALSE) 
# all arguments can be vectors 
v1 = c(2,5,6,3,2) 
v2 = c("hello", "rain", "year", "sun") 
v3 = c("q", "w", "e", "r", "t", "y") 
ifelse(v1 > 2, v2, v3)

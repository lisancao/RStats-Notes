
#################################################### REPEAT LOOPS
# loops that execute and then check for an end statement
# using repeat WILL result in continuous execution of the code until you quit R
endlesshog <- repeat { 
  message("HOG HOG HOG HOG HOG HOG")} 

# use a break statement to end the loop 
repeat { 
  message("HOG HOG HOG HOG HOG HOG")
  MSG <- sample(
    c(
      "HIG HIG HIG HIG", 
      "HUG HUG HUG",
      "HEG HEG", 
      "HAG"
    ), 
    1
  )
  message("MSG = ", MSG)
  if(MSG == "HAG") break
  }

# Forcing the next iteration 
repeat { 
  message("Vancouver is..")
  weather <- sample(
    c("rainy", "sunny", "drab", "westcoast"), 
    1) 
  if(weather == "drab") { 
    message("Well what did you expect?")
    next }
  message("weather = ", weather)
  if(weather == "westcoast") break
  } 

# note that indentation and bracketting is very important 
repeat 
{ 
  message("Vancouver is..")
  weather <- sample(
    c(
      "rainy", 
      "sunny", 
      "drab", 
      "westcoast"
      ), 
    1
  ) 
  if(weather == "drab") 
  { 
    message("Well what did you expect?")
    next 
  }
  message("weather = ", weather)
  if(weather == "westcoast") break
}

################################################### WHILE LOOPS
# while loops take in end arguments before executing the code, unlike repeat statements which do the opposite 
x = 1
while (x < 10) {
  print(x)
  x = x + 1
}

# using a while loop to break a repeat loop 
message("Vancouver is..")
weather <- sample( c(
      "rainy", 
      "sunny", 
      "drab", 
      "westcoast"
    ), 
    1
  ) 
  while(weather == "drab") { 
    message("Well what did you expect?")
    weather <- sample(
      c(
        "rainy", 
        "sunny", 
        "drab", 
        "westcoast"
      ), 
      1
    ) 
  message("weather = ", weather)
}

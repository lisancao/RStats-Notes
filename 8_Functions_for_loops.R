#################################################### FOR LOOPS

# a loop that iterates a a specific amount of time, accepts iterator variable and a vector 

for (i in 1:5) { 
  j = i ^ 2
  message("j is now.. ", j)
}

# r for loops are not limited to integers 

for (month in month.name) {
  if(month == "January") {
    message("The first month is ", month) 
  }
  else if(month == "August") { 
    message("My birthday month is ", month)}
  else if(month == "October") {
    message("My favourite month is ", month)
  }
  else {
    message("The next month is ", month)
  }
}

# another example using a mixed list 
random <- list( 
  c("Saint Bernese", "Golden Retriever", "Pitbull", "Mixed Breed"),
  letters[1:11], 
  charToRaw("It's fookin raw!")
  )

for(i in random) {
  print(i) 
}



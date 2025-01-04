## R program/script that takes 20 inputs(integers) and return the sim of only odd number.
  
  # Initialize the sum
  sum_of_odds <- 0
  
  # Loop to take 20 inputs
  for(i in 1:20) {
    # Take input from user
    print(paste("Enter number ", i, ":"))
    num <- as.integer(readline())
    
    # If the number is odd, add it to the sum
    if(num %% 2 != 0) {
      sum_of_odds <- sum_of_odds + num
    }
  }
  
  # Print the sum of odd numbers
  print(paste("Sum of Odd Numbers: ", sum_of_odds))


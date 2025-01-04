## R program/script to show maximum of three number. Choose user input to take three number.

# Take 3 integer from user
input_1 <- as.integer(readline(prompt = "Enter the first number: "))
input_2 <- as.integer(readline(prompt = "Enter the second number: "))
input_3 <- as.integer(readline(prompt = "Enter the third number: "))


# Find the maximum number
find_max <- max(input_1, input_2, input_3)

# Print the maximum number
print(paste("The greatest number is:", find_max))

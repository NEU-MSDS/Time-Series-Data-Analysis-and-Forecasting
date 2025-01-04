# Load Package Library
library(zoo) # time series ordered observations
library(xts) 
library(quantmod)

# Get the historical data from yahoo finance 
getSymbols("PHP=X", from = "2018-01-01", to = "2024-04-29")

# Load the data
data <- "PHP=X"

top

# EDA the data
is.null(data) # check if there is missing values in data

# Transform data without the missing values
## Option 1: Clean Data
#cleaned_data <- na.omit(data) # remove rows with missing values

## Option 2: Impute missing values
#interpolated_data <- na.approx(data) 

## Option 3: Replace missing values with mean
data[is.na(data)] <- mean(data, na.rm = TRUE) # fill missing value with the mean of the non-missing values

## Option 4: Forward-filling
#forward_filled_data <- zoo::na.locf(data) # propagate the last known value forward to fill missing values

## Option 5: Complete Cases
complete_cases_data <- data[complete.cases(data), ] # identify rows with complete data






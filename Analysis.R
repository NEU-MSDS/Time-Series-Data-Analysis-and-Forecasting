# Load necessary libraries
library(ggplot2)
library(forecast)
library(lubridate)
library(imputeTS)

# Load the dataset
data <- read.csv('C:/Users/namortel/OneDrive - PLDT/Study/BatState-U/MSDS/MSDS 511 - Time Series Data Analysis and Forcasting/Broadband Traffic Prediction/Traffic and Usage.csv')

# Check if data is loaded correctly
head(data)

# Check the column names of data
colnames(data)

# Check for NA values
sum(is.na(data$Total_Internet_Traffic.Tbps))
sum(is.na(data$Fixed_Traffic.Tbps))
sum(is.na(data$Fixed_Usage.PB))
sum(is.na(data$Fixed_Ave_Usage_Per_Subs.GB))

# Interpolate the missing data
data$Fixed_Usage.PB <- na_interpolation(data$Fixed_Usage.PB)
data$Fixed_Ave_Usage_Per_Subs.GB <- na_interpolation(data$Fixed_Ave_Usage_Per_Subs.GB)

# Recheck missing value if still null after imputation
sum(is.na(data$Fixed_Usage.PB))
sum(is.na(data$Fixed_Ave_Usage_Per_Subs.GB))

# Convert 'Date' to a date object and set it as a ts object
data$Date <- mdy(data$Date)

# Create time series objects
total_traffic_ts <- ts(data$"Total_Internet_Traffic.Tbps", start=c(2020,1), frequency=12)
fixed_traffic_ts <- ts(data$"Fixed_Traffic.Tbps", start=c(2020,1), frequency=12)
fixed_usage_ts <- ts(data$"Fixed_Usage.PB", start=c(2020,1), frequency=12)
fixed_ave_usage_per_subs_ts <- ts(data$"Fixed_Ave_Usage_Per_Subs.GB", start=c(2020,1), frequency=12)


# Explore the structure and summary of the dataset
str(data)
summary(data)

# Time series plot of PLDT-Smart internet traffic
ggplot(data, aes(x=Date, y=`Total_Internet_Traffic.Tbps`)) +
  geom_line() +
  scale_y_log10() +
  labs(title="Total Internet Traffic")

# Time series plot of PLDT traffic
ggplot(data, aes(x=Date, y=`Fixed_Traffic.Tbps`)) +
  geom_line() +
  scale_y_log10() +
  labs(title="Fixed Traffic")

# Time series plot of PLDT Usage
ggplot(data, aes(x=Date, y=`Fixed_Usage.PB`)) +
  geom_line() +
  scale_y_log10() +
  labs(title="Fixed Usage")

# Time series plot of PLDT Usage
ggplot(data, aes(x=Date, y=`Fixed_Ave_Usage_Per_Subs.GB`)) +
  geom_line() +
  scale_y_log10() +
  labs(title="Fixed Average Usage Per Subscriber")

# Decomposition of time series to observe trends and seasonality
decomposed_total_traffic <- stl(total_traffic_ts, s.window="periodic")
plot(decomposed_total_traffic)

decomposed_fixed_traffic <- stl(fixed_traffic_ts, s.window="periodic")
plot(decomposed_fixed_traffic)

decomposed_fixed_usage <- stl(fixed_usage_ts, s.window="periodic")
plot(decomposed_fixed_usage)

decomposed_fixed_ave_usage_per_subs <- stl(fixed_ave_usage_per_subs_ts, s.window="periodic")
plot(decomposed_fixed_ave_usage_per_subs)


# Create a training set and a validation set
train <- window(total_traffic_ts, end = c(2023,12)) 
validation <- window(total_traffic_ts, start = c(2024,1)) 

# Fit an ARIMA model
model <- auto.arima(train)

# Print the model summary
summary(model)

# Generate forecasts
forecast <- forecast(model, h=12)

# Create a data frame from the forecast object
forecast_df <- data.frame(
  Date = seq(max(data$Date), by = "month", length.out = 13)[-1],
  Lower80 = forecast$lower[, 2],
  Upper80 = forecast$upper[, 2],
  Forecast = forecast$mean
)

# Combine actual and forecasted data
combined_data <- rbind(
  data.frame(Date = data$Date, Value = data$Total_Internet_Traffic.Tbps, Type = "Actual"),
  data.frame(Date = forecast_df$Date, Value = forecast_df$Forecast, Type = "Forecast")
)

# Plot the actual and forecasted values with ggplot2
ggplot(combined_data, aes(x = Date, y = Value, color = Type)) +
  geom_ribbon(data = forecast_df, aes(x = Date, ymin = Lower80, ymax = Upper80), fill = "grey80", alpha = 0.5, inherit.aes = FALSE) +
  geom_line() +
  labs(x = "Month", y = "Total Internet Traffic (Tbps)", title = "ARIMA Forecast of Total Internet Traffic") +
  scale_color_manual(values = c("Actual" = "red", "Forecast" = "green"))

# Validate the developed ARIMA Model
checkresiduals(model)

forecast <- forecast(model, h=length(validation))

# Calculate error metrics
mae <- mean(abs(forecast$mean - validation))
rmse <- sqrt(mean((forecast$mean - validation)^2))
mape <- mean(abs((forecast$mean - validation) / validation))

cat("MAE:", mae, "\n")
cat("RMSE:", rmse, "\n")
cat("MAPE:", mape, "\n")


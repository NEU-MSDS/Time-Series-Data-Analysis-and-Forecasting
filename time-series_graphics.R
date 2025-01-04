# importing useful libraries
library(ggplot2)
library(ggfortify)

# creating ts object
z=c(10,20,30,40,50,60,70,80,88,87)
y <- ts(z, start=2003)
print (y)

library(fpp)
plot(melsyd)
library(fpp2)

#plot antidiabetic drug
autoplot(a10)
  ggtitle("Antidiabetic")
  ylab("$million")
  xlab("Year")
  
'#seasonal plot, plotted 
ggseasonplot(a10, year.labels=TRUE, year.labels.left=TRUE) +
  ylab("$ million") +
  ggtitle("Seasonal plot: antidiabetic drug sales"
'
  

#the time series axis circular rather than horizontal
ggseasonplot(a10, polar=TRUE) +
  ylab("$ million") +
  ggtitle("Polar seasonal plot: antidiabetic drug sales")
          

#lag plot for ausbeer dataset
beer2 <- window(ausbeer, start=1992)
gglagplot(beer2)



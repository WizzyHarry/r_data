rm(list = ls(envir = globalenv()), envir = globalenv());
if(!is.null(dev.list())) dev.off(); gc(); cat("\014")


# The quantmod package scrapes data (stock prices, exchange rates, etc) 
# from sources such as Yahoo finance and directly displays it into R. 

library(quantmod)
library(rstudioapi)
library(dplyr)
library(ggplot2)
setwd(selectDirectory(caption = "Select your working directory"))

# Shows installed packages
user_installed <- setdiff(
  rownames(installed.packages()),
  rownames(installed.packages(priority = c("base", "recommended")))
)

# Updates packages
update.packages()


# Shows pre-configured datasets within R
# data()


# Creates a barchart with data from AAPL, can specify range
# getsymbols is used to fetch historical stock prices
getSymbols("AAPL")
barChart(AAPL)
barChart(AAPL["2007-04-01::2024-12-31"])
# After Steve Jobs, Apple started giving more attention to private shareholders.


# pre-loaded R file I'll be manipulating
mtcars 


# Display first 6 rows. Same as pandas
head(mtcars)


# Display last 10 rows. Same as pandas
tail(mtcars, 10)


# Allows you to view data structures (interpretation)
str(mtcars)


# Creates a correlation matrix. Ranges from -1 to 1.
cor(mtcars)


# Find the avg mpg of all vechiles excluding NULL's.
mean(mtcars$mpg, na.rm = TRUE)


# Choose computes a binomial coefficient
# choose(n, k). K MUST BE >= n. This could be interpreted as "how many ways
# to choose 4 samples out of a sample size of 15".
choose(15,4)


# Displays column names
names(mtcars)

# Slicing columns method
mtcars[,2:4]


# Shows True & False values based on the index position of mpg
# R-Indexing starts at 1 not zero.
mtcars$mpg>20

# While this shows all values with mpg>20
mtcars[mtcars$mpg>20,]

# Same as above, but constrains to the selected columns
mtcars[mtcars$mpg>20,c("mpg","hp","cyl")]


# Attach and detach remove the need to use $ to specify columns
attach(mtcars)
mpg20 <- mtcars$mpg > 20
detach()


# Select statements. Middle is the argument (mpg>20)
subset(mtcars, mpg>20, c("mpg","cyl"))
subset(mtcars, , c("mpg","hp"))

# DPLYR package select filtering
filter(mtcars, mpg>20)
select(mtcars, mpg, hp)

# Creates a dot plot based on displacement & mpg values
plot(mtcars$disp, mtcars$mpg)

# Same dot plot but with labeling
plot(mtcars$disp, mtcars$mpg, xlab="Engine Displacement",
     ylab="MPG", main="MPG v. Displacement")


# Same dot plot, utilizing ggplot methods
qplot(disp, mpg, data=mtcars)
# ylim sets constraints for the range of Y. In this case making the graph bigger
# because cars all have net positive miles per gallon. 
qplot(disp, mpg, ylim=c(0,35), data=mtcars)


# Using ggplots mpg dataset. 
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_jitter()


# Using ggplots Air pressure dataset, able to measure the correlation 
# between pressure & temperature. 
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line()
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()

# Utilizes R's Biochemical Oxygen Demand dataset
barplot(BOD$demand)
barplot(BOD$demand, main="Graph of demand"
        , names.arg = BOD$Time)

# Creates the value: cylcount
cylcount <- table(mtcars$cyl)

# Shows the differences between a ggplot v. R-plot
barplot(cylcount)
qplot(mtcars$cyl)


# Shows the distribution of mpg
boxplot(mtcars$mpg)

# Creates values for color mapping
mycolors <- heat.colors(3)
mrecolors <- rainbow(6)


# Basic computations
# Set value
a <- 9
# Non-altering computation
a + 5

# Set value
b <- sqrt(a)
# Display value
b

c <- c(1,2,5.3,6,-2.4)
c

# Display value types in vector (c)
typeof(c)

# Is datatype Boolean commands
is.list(c)
is.vector(c)

d <- c("one", "two", "three")
typeof(d)


e <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)
e
# R views Boolean as Logic
typeof(e)

# Indexing starts at 1
d[1]

# Can do function computations from a vector
min(c)
max(c)
mean(c)
sum(c)

# dir() shows other files in directory. getwd() shows the working directory
dir()
getwd()
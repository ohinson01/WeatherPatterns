# Weather Patterns
# Date: 3/21/2024

getwd()
#setwd("C:\\Users\\ohins\\OneDrive\\Documents\\Udemy\\R_Programming-Advanced_Analytics_in_R_for_Data_Science\\Section_4-Applied_Family_of_Functions\\Weather-Data")
#setwd(".\\Udemy\\R_Programming-Advanced_Analytics_in_R_for_Data_Science\\Section_4-Applied_Family_of_Functions\\Weather-Data")
getwd()

# Read Data
Chicago <- read.csv(".\\Udemy\\R_Programming-Advanced_Analytics_in_R_for_Data_Science\\Section_4-Applied_Family_of_Functions\\Weather-Data\\Chicago-F.csv", stringsAsFactors = T, row.names = 1)
#Chicago <- read.csv(".\\Udemy\\R_Programming-Advanced_Analytics_in_R_for_Data_Science\\Section_4-Applied_Family_of_Functions\\Weather-Data\\Chicago-F.csv", stringsAsFactors = T)
NewYork <- read.csv(".\\Udemy\\R_Programming-Advanced_Analytics_in_R_for_Data_Science\\Section_4-Applied_Family_of_Functions\\Weather-Data\\NewYork-F.csv", stringsAsFactors = T, row.names = 1)
Houston <- read.csv(".\\Udemy\\R_Programming-Advanced_Analytics_in_R_for_Data_Science\\Section_4-Applied_Family_of_Functions\\Weather-Data\\Houston-F.csv", stringsAsFactors = T, row.names = 1)
SanFrancisco <- read.csv(".\\Udemy\\R_Programming-Advanced_Analytics_in_R_for_Data_Science\\Section_4-Applied_Family_of_Functions\\Weather-Data\\SanFrancisco-F.csv", stringsAsFactors = T, row.names = 1)
# Check
# Chicago
Chicago
NewYork
Houston
SanFrancisco
# these are dataframes:
is.data.frame(Chicago)
# Let's convert to matrices:
Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFrancisco <- as.matrix(SanFrancisco)
# Check
is.matrix(Chicago)
# Let's put all of these into a list:
Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFrancisco=SanFrancisco)
Weather
# Let's try it out: 
Weather[3]
Weather[[3]]
Weather$Houston

# ----------------------------------------

# Using apply()
?apply
Chicago
# Average of rows 
apply(Chicago, 1, mean)
# Check
mean(Chicago["DaysWithPrecip",])
# Analyze one city: 
Chicago
apply(Chicago, 1, max)
apply(Chicago, 1, min)
# For practice: 
apply(Chicago, 2, max) # Doesn't make much sense, but good exercise
apply(Chicago, 2, min)
# Compare: 
apply(Chicago, 1, mean)
apply(NewYork, 1, mean)
apply(Houston, 1, mean)
apply(SanFrancisco, 1, mean)
                             #>>> (nearly) deliv 1: but there is a faster way

# ----------------------------------------

# Recreating the apply function with loops (advanced topic)
Chicago
# Find the mean of every row: 
# 1. via loops
output <- NULL # Preparing an empty vector
for(i in 1:5) { # Run cycle
  output[i] <- mean(Chicago[i,])
} 
output      # Let's see what we have
names(output) <- rownames(Chicago)
output
# 2. Via apply function
apply(Chicago, 1, mean)

# ----------------------------------------

# Using lapply()
?lapply
Chicago
t(Chicago)
Weather
lapply(Weather, t) # t(Chicago), t(NewYork), t(Houston), t(SanFrancisco)
mynewlist <- lapply(Weather, t)
mynewlist
# Example 2
Chicago
rbind(Chicago, NewRow=1:12)
lapply(Weather, rbind, NewRow=1:12)
# Example 3
?rowMeans
rowMeans(Chicago) # Identical to apply(Chicago, 1, mean)
lapply(Weather, rowMeans)
                          #>>> (nearly) deliv 1: even better, but will improve further
# rowMeans
# colMeans
# rowSums
# colSums

# ----------------------------------------

# Combining lapply with the [ ] operator
Weather
Weather[[1]][1,1]    # Weather[[1]][1,1], Weather[[2]][1,1],...
#Weather$Chicago[1,1] # Weather$Chicago[1,1], Weather$NewYork[1,1],...
lapply(Weather, "[", 1, 1) # Weather[[1]], Weather[[2]],...
Weather
lapply(Weather, "[", 1, )
Weather
lapply(Weather, "[", , 3)

# ----------------------------------------

# Adding your own functions
lapply(Weather, rowMeans)
lapply(Weather, function(x) x[1,])
lapply(Weather, function(x) x[5,])
lapply(Weather, function(x) x[,12])
Weather
lapply(Weather, function(z) z[1,] - z[2,])
lapply(Weather, function(z) round((z[1,] - z[2,])/z[2,], 2))
                                          #>>Deliv 2: temp fluctuations. Will improve

lapply(Weather, function(y) round(y[3,]/y[4,]))

# ----------------------------------------

# Using sapply()
?sapply
Weather
# AvgHigh_F for July
lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)
# AvgHigh_F for 4th quarter
lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12)
# Another example: 
lapply(Weather, rowMeans)
sapply(Weather, rowMeans)
round(sapply(Weather, rowMeans), 2) #>> Deliv 1. Awesome!
# Another example
lapply(Weather, function(z) round((z[1,] - z[2,])/z[2,], 2))
sapply(Weather, function(z) round((z[1,] - z[2,])/z[2,], 2)) #>> Deliv 2. Awesome!
# By the way
sapply(Weather, rowMeans, simplify=FALSE, USE.NAMES = FALSE)

# ----------------------------------------

# Nesting Apply Functions
Weather
lapply(Weather, rowMeans)
?rowMeans
Chicago
apply(Chicago, 1, max)
# Apply across whole list: 
lapply(Weather, apply, 1, max) # Preferred approach
lapply(Weather, function(x) apply(x, 1, max))
# Tidy up
sapply(Weather, apply, 1, max) #>> deliv 3
sapply(Weather, apply, 1, min) #>> deliv 4

# ----------------------------------------

# Very advanced tutorial: 
# which.max
?which.max
which.max(Chicago[1,]) #  Give index of where max is
names(which.max(Chicago[1,]))
# By the sounds of it:
# We will have apply - to iterate over rows of the matrix
# and we will have lapply or sapply - to iterate components of the list
apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))









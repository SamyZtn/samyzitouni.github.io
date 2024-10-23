#####################################
# R TUTORIAL 1 : Data visualisation
# Author : Samy Zitouni
#####################################

# This code is a brief draft of lines that aim to test some codes and properties of R
# For more details, please see the corresponding slides for tutorial 1


# ======================== ENVIRONMENT ======================================
install.packages('dplyr') # Installing the package

library(dplyr) # Loading package : the functions are available



# Path (you may need to create the folders)
path <- '' # Enter your own path
path_input <- paste0(path, '/1_inputs/') # Path for an input folder in your general folder (the one for path)
path_output <- paste0(path, '/2_outputs/') # Path for an output folder


# ========================= CODE ============================================

# ---------- Defining variables ---------

x <- 3 # Assign the value 3 to x
window <- 'This is a window' 
grades <- c(12, 10, 20) # Vectors are a way to store a list of several values
can = "this is a can"



# ------------- Functions ----------------

meanGrades <- mean(grades) # Function that is included in R. The result is assigned to the variable meanGrades


max(grades) # Directly returns the value in the console, without assigning it



opener <- function(x){
  # This function opens a window
  #in: character
  #out: character
  return(paste0(x, ' thats is opened')) # Return is present so that it return something when you call the function
}

f <- function(x){return(x+3)} # Function that adds 3 to a number x

# Calling the functions
opener(window) # Apply the function opener to the object window. Return the result in the console

openedCan <- opener(can) # Apply the function opener to the object can and assign the
                         # result to a new object called openedCan





# Importing IMDB database : top 250 movies
imdb = read.csv('C:/Users/C09581/Desktop/R tutorials/1_inputs/imdb_top250_french.csv', fileEncoding = "utf-8")
help(read.csv) # Help for the function
head(imdb, 3) # Prints the first 3 lines
tail(imdb, 4) # Prints the last 4 lines
View(imdb) # Opens the dataset to view it in a separate window


# BOOLEANS
# TRUE / FALSE value
# R is able to perform operations and check if an assertion is TRUE of FALSE

is_it_true <- (3 > 4) || (3 == 3)
t <- TRUE
and <- (3==3) && (4==5) # Determines is this assertion is true or false, and assign the result to the variable t
v <- 4 != 5 # Determines if 4 is diff from 5 and assigns it to v


# TYPES
# Each scalar has a type, that can be converter sometimes, sometimes not.

# Numeric to character
year <- 2010 
class(year) # Numeric
as.character(year)
class(as.character(year)) 

# Characater to numeric
window = "my window"
duration = "45"
as.numeric(window) # Does not work
as.numeric(duration) # Works: R is able to identify that it is a numeric value


# Working on sub-strings
help(substr)
help(gsub)
gsub(' min', '', '34 min') # Removing a part of a string



# IMDB Database

# Basic manipulation
colnames(imdb) #check column names
glimpse(imdb)
imdb$Name # Call a column 


View(imdb[imdb$Rank < 15 & imdb$Rank > 10,]) # Subsetting for ranks between 10 and 15



# DPLYR
#install.packages('dplyr')

library(dplyr)

imdb %>%
  filter(Rank <15 & Rank > 10)%>%
  View() 



imdb2 <- imdb %>%
  select(Name, Rank, Duration, Genre, Rating, MetaScore) %>%
  mutate(
    istop50 = ifelse(Rank <= 50, 'yes', 'no'), # Create a top 50 identifier
    Duration = as.numeric(gsub('min', '', Duration)) # Convert duration to mins
  ) %>%
  filter(Name != "Amélie") %>% # Not interested in the Amélie movie
  arrange(-Rank) # Sort rows


# Compute basic grouped stats
imdb2 %>% mutate(
  firstGenre = trimws(sapply(strsplit(Genre, ","), '[', 1)) # take the first mentionned genre in the genre character string
  )%>%
  group_by(firstGenre) %>%
  summarise(
    meanScore = mean(Rating, na.rm = T),
    avgDuration = mean(Duration, na.rm = T),
    avgMetaScore = mean(MetaScore, na.rm = T)
  ) %>% View()





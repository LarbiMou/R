
setwd("yourdirectory/LAB01")
getwd() 


lab1 <- read.table("lab1_01.txt", sep="|", header=TRUE)
lab2 <- read.table("lab1_02.txt", sep="|", header=TRUE) 

# look at some data values 

head(lab1, n=10)
tail(lab2, n=10)

# lets look in more detail 


summary(lab1)

# and remove some extraneous variables (columns). "Serial No" #does not serve has any good

nlab1 <- lab1[,2:3]

# what did we get? 
## show me how may rows and columns. 
dim(nlab1)
## What is the type of the element in this variable. 
typeof(nlab1)
## Why list? Lets see the type of variable itself
class(nlab1)


# what does summary() say now? 


summary(nlab1)

# same correlation values or different? 

cor(nlab1)

# clean up and save

rm(lab1) 
lab1 <- nlab1
save(lab1, lab2, file="Labs.Rdata")
rm(lab1, lab2)
ls()      # make sure they?re not in the workspace
## What if you have 100 objects in workspace, how would you
## delete all the objects? 
rm(list=ls())


###################################################
## Step 1: scalars and strings
###################################################

n <- 1  # scalar
s <- "Loyola University Chicago FALL 2015"   # string 

###################################################
## Step 2: vectors of strings and numbers
################################################### 

levels <- c("Worst", "Bad", "Mediocre", "Good", "Awesome")
ratings <- c("Worst", "Worst", "Bad", "Bad", "Good", "Bad", "Bad") 
critics <- c("Siskel", "Ebert", "Rowen", "Martin")
movies <- c("The Undefeated", "Snakes on a Plane", "Encino Man", "Casablanca")
attendance <- c(15, 350,175, 400)
reviewers <- c("Siskel", "Siskel", "Ebert", "Ebert", "Rowan", "Martin", "Rowan")

###################################################
## Step 3: factors and lists
###################################################
f <- factor(ratings, levels)  
 
fl <- list(ratings=ratings, critics=critics, 
		movies=movies, attendance=attendance)
	
###################################################
## Step 4: Matrices, Tables, and Data Frames
###################################################

mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol=3, byrow=TRUE,
               dimnames = list(c("row1", "row2"),
					 c("C1", "C2", "C3")))
					 
t <- table(ratings, reviewers)  

## do the same thing with another route
## cbind combines two vectors by column. Wonder what rbind does? 
## does it bind by rows? 
ti <-cbind(ratings, reviewers) 
print(ti)
## as.data.frame converts ti to a dataframe
td <-as.data.frame(ti)
t<-table(td)
print(t)
###################################################
## Step 5: Defining a Function
###################################################

standev <- function(x) sd(x)   # defining a function 
v <- c(1:100)              # create a test vector
standev(v)

## How to install packages

## How to connect to PostgreSQL database. Install package first. 
install.packages("RPostgreSQL")
## Call the library
library(RPostgreSQL)
## establish the connection
conn<-dbConnect("PostgreSQL",dbname="loyolainfs",host="147.126.21.240", port=8432, user="classdemo", password="spring202!")
## query the data and put it in a variable. 
mytable=dbGetQuery(conn, "select * from zagi.product")
## See the type of variable 
class(mytable)
str(mytable)
head(mytable)
###################################################
## End 
###################################################

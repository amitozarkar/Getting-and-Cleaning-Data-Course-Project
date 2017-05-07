# Project :Coursera Getting and Cleaning data project
# Purpose :The purpose of this project is to demonstrate your ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
# Date : 6-May-2017 
# Created By : Amit S. Ozarkar
#-----------------------------------------------------------------------------------------------#

#----------------------------File downloading Part----------------------------------------------#
# create the new directory as project
  if(!file.exists("C://Amit//DataScience//Coursera//Project")){dir.create("C://Amit//DataScience//Coursera//Project")}

# Set the working directory
setwd ("C://Amit//DataScience//Coursera//Project")

# download the file from the given location
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url,"dataset.zip")

# unzip the file
unzip("dataset.zip")

#check the files in the directory
list.file()

#changing the working directory to make my work easy
setwd (".//UCI HAR Dataset")

#-----------------------------------------------------------------------------------------------#

#loading the activity labels files
activitylabels <- read.table("activity_labels.txt")
colnames(activitylabels) <- c("actid","activityname")

#loading the features files
features <- read.table("features.txt")
colnames(features) <- c("featureid","feature")

#--------------------seperating required features of Mean and Std Dev--------------------------------#
features_reqd <- grep("mean()|std()",features$feature)

######################################################################################################
#----------------------Processing Training Data Set Start--------------------------------------------#
#loading x_train.txt and y_train.txt
x_train <- read.table(".//train//X_train.txt")

#Assigning the appropriate names to columns of x_train from features data set to x_train data set.
colnames(x_train) <- features$feature

#----------------From x_train, extracting columns of mean and std deviations-------------------#
x_train_reqd <-x-train[,features_reqd]

y_train<- read.table(".//train//y_train.txt")
colnames(y_train) <-c("actid")
#combining x_train & y_train data sets
train <- cbind(y_train,x_train_reqd)

#----------------------Processing Training Data Set Complete -----------------------------------#

#################################################################################################

#----------------------Processing Test Data Set Start-------------------------------------------#
#loading x_test.txt and y_test.txt
x_test <- read.table(".//test//X_test.txt")

#Assigning the appropriate names to columns of x_test from features data set to x_test data set.
colnames(x_test) <- features$feature

#-----------------From x_test, extracting columns of mean and std deviations--------------------#
x_test_reqd <-x_test[,features_reqd]

y_test<- read.table(".//test//y_test.txt")
colnames(y_test) <-c("actid")

#combining x_train & y_train data sets
test <- cbind(y_test,x_test_reqd)
#----------------------Processing Training Data Set Complete -----------------------------------#
#################################################################################################

#----------------------Merging both data sets i.e Train & Test----------------------------------#

superDS <- rbind(train,test)

#-----providing descriptive activity names to name the activities in the data set---------------#
superDS<-merge(activitylabels,superDS,by.x = "actid",by.y = "actid")

# ---- Making the column names appropriate/readable --------------------------------------------#
colnames(superDS) <- gsub("[()]","",names(superDS))

# ---------------------------- Loading Subject Data --------------------------------------------#
subject_train <- read.table(".//train//subject_train.txt")
subject_test <- read.table(".//test//subject_test.txt")
subject <- rbind(subject_train,subject_test)  # total records is #10299
colnames(subject) <- c("subject")

# -------------Lets combine subject with SuperDS -----------------------------------------------#
superDS <- cbind (subject,superDS)

#superDS1 <- superDS[superDS$actid==1 & superDS$subject==1,c(1,2,4)]

#removing column activityname as its non numeric for timebeing, will add it finally
superDS <- superDS[,-3]

#---------- Taking mean by Activity by Subject -------------------------------------------------#
library(dplyr)
#act_subj <- group_by(superDS1,c(subject,actid))
#tidyDS <- summarize_each(act_subj,funs(mean))

tidyDS <- superDS%>%group_by(actid,subject)%>%summarise_each(funs(mean))

#----------Lets add Activity Names to tidyDS---------------------------------------------------#
tidyDS <- merge(activitylabels,tidyDS,by.x = "actid",by.y = "actid")

#----------exporting tidy data set in to tydy DS.txt--------------------------------------------#
write.table(tidyDS,"tidyDS.txt",row.names=F,quote=F)

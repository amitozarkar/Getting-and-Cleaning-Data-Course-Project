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

#----------------------------------------------------------------------------------------------------#
#loading the features files
features <- read.table("features.txt")
colnames(features) <- c("featureid","feature")

#--------------------seperating required features of Mean and Std Dev--------------------------------#
features_reqd <- grep("-(mean|std)\\(\\)",features$feature)

######################################################################################################
#-----------------Step1:Merges the training and the test sets to create one data set-----------------#
x_train <- read.table(".//train//X_train.txt")
x_test <- read.table(".//test//X_test.txt")

y_train<- read.table(".//train//y_train.txt")
y_test<- read.table(".//test//y_test.txt")

subject_train <- read.table(".//train//subject_train.txt")
subject_test <- read.table(".//test//subject_test.txt")

x_merge <- rbind(x_train,x_test)
y_merge <- rbind(y_train,y_test)
subject_merge <-rbind(subject_train,subject_test)

#Assigning the appropriate names to columns of x_train from features data set to x_train data set.
names(x_merge) <- features[,2]
names(y_merge) <-c("actid")
names(subject_merge) <-c("subid")

#--Step2:Extracts only the measurements on the mean and standard deviation for each measurement.------#
x_merge_reqd <-x_merge[,features_reqd]

#combining x_merge, y_merge and subject_merge data sets
super_merge <- cbind(y_merge,subject_merge,x_merge_reqd)

##################################################################################################

#loading the activity labels files
activitylabels <- read.table("activity_labels.txt")
colnames(activitylabels) <- c("actid","activityname")

# ----Step3 : Adding Activity Names in the data set --------------------------------------------#
super_merge <- merge(activitylabels,super_merge,by.x = "actid",by.y = "actid")

# ---- Step4:Making the column names appropriate/readable ---------------------------------------#
colnames(super_merge) <- gsub("[()]","",names(super_merge))

# taking out the non numeric column activityname out, will add again, to avoid warnings during in group_by
super_merge <- super_merge[,-2]

#-------Step5: Taking mean by Activity by Subject -------------------------------------------------#
library(dplyr)
tidyDS <- super_merge%>%group_by(subid,actid)%>%summarise_each(funs(mean))

#----------Lets add Activity Names to tidyDS---------------------------------------------------#
tidyDS <- merge(activitylabels,tidyDS,by.x = "actid",by.y = "actid")

#----------exporting tidy data set in to tydy DS.txt--------------------------------------------#
write.table(tidyDS,"tidyDS.txt",row.names=F,quote=F)
############################     End    ##########################################################
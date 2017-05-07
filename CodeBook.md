This CodeBook explains the overall flow of run_Analysis.R script.
Below is the flow of program written

1. The first part of the script creates the directory and loads the files from internet.
2. Data sets for train,test are individually combined using rbind for x,y and subject which are then merged together using cbind to form   
   super_merg dataset.
3. Features also extracted and out of that feature names containing mean and std dev are extracted in feature_reqd vector.
4. This vector is used later on to extract same columns from super_merge dataset

Variable Names and their purpose is as follows
1. x_merge : represent the x_test and x_train data sets merged by row bind.
2. x_merge_reqd : subset of x_merge with columns containing names as mean or std dev.
3. y_merge : represent the y_test and y_train data sets merged by row bind.
4. subject_merge : represent the subject_test and subject_train data sets merged by row bind.
5. super_merge : represents a merged dataset by column bind of three data sets : x_merge_reqd,y_merge,subject_merge
6. tidyDS : final dataset with mean values for all the columns of superDS

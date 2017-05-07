This CodeBook explains the overall flow of run_Analysis.R script.
Below is the flow of program written

1. The first part of the script creates the directory and loads the files from internet.
2. Loading of Activity and Features in the R.
3. Loads the x_train.txt data set, assigns it appropriate column names from features and takes out a separate data set with columns
   related to mean and std. dev from it in x_train_reqd dataset.
4. Merge y_train data set which contains activity ids only with x_train_reqd.
5. This makes training Data Set complete.
6. Same steps are followed fr Test Data set.
7  Finally both Train and Test Data Sets (with required columns only i.e. mean and std. dev related) are merged using rbind in superDS.
8. From superDS, column headers are made appropriate and readable using gsub() by just removing "()"
9. Finally using dplyr library and group_by and summarise_each function with chain operation, tried to calculate the mean for all columns.
10 Lastly the data is exported in tidyDS.txt

Variable Names as purpose are as follows
x_train_reqd,x_test_reqd,features_reqd : datasets with columns extracted related to mean and std dev from x_train and x_test
superDS : row wise merged data set of x_train_reqd and x_test_reqd(with few more steps, see code)
tidyDS : final dataset with mean values for all the columns of superDS



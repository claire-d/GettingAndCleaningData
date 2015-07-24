# GettingAndCleaningData

The script run_analysis.R reads in and cleans the Human Activity Recognition Using Smartphones Data Set. 

Firstly, it reads in the training and test data sets separately and for each of these data sets, it appends the applicable subject identifiers and activity codes. It then merges the training and test sets, extracts the variables containing the mean and standard deviation (while retaining the subject identifiers and activity codes). Next, it substitutes the descriptive activity names for the numeric codes used in the activity variable. 

Finally, it generates a separate data set containing the average of the mean and standard deviation for each measurement for each activity for each subject and outputs this new data set as "tidy.txt" in the present working directory. 

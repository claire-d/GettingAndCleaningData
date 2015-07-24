library(plyr)
library(dplyr)

### Prepare the training set

# Read training set
X.train <- read.table("UCI HAR Dataset//train//X_train.txt")
# Add features names to training set
names(X.train) <- feature.names
# Read the subject identifiers for the training set
subjectID.train <- read.table("UCI HAR Dataset//train//subject_train.txt")
Subject <- as.character(subjectID.train[,1])
# Read the activity codes for the training set
activitycode.train <- read.table("UCI HAR Dataset//train//y_train.txt")
Activity <- as.character(activitycode.train[,1])
# Add subject identifiers and activity codes to the training set
X.train <- cbind(Subject, Activity, X.train)

### Prepare the test set

# Read the test set
X.test <- read.table("UCI HAR Dataset//test//X_test.txt")
# Add features names to test set
names(X.test) <- feature.names
# Read the subject identifiers for the test set
subjectID.test <- read.table("UCI HAR Dataset//test//subject_test.txt")
Subject <- as.character(subjectID.test[,1])
# Read the activity codes for the test set
activitycode.test <- read.table("UCI HAR Dataset//test//y_test.txt")
Activity <- as.character(activitycode.test[,1])
# Add subject identifiers and activity codes to the test set
X.test <- cbind(Subject, Activity, X.test)

### Merge the training and test sets

data <- rbind(X.train, X.test)

### Extract mean and standard deviation for each measurement

toMatch <- c("Subject","Activity","mean","std")
notMatch <- "meanFreq"
summary.data <- data[, grep(paste(toMatch,collapse="|"), colnames(data))]
# Exclude variables containing "meanFreq"
summary.data <- summary.data[, grep("meanFreq", colnames(summary.data), invert=T)]

    # ref for using grep to subset a dataframe: http://stackoverflow.com/questions/13043928/selecting-rows-where-a-column-has-a-string-like-hsa-partial-string-match
    # ref for using grep to match >1 pattern: http://stackoverflow.com/questions/7597559/grep-in-r-with-a-list-of-patterns

### Add descriptive activity names to Activity variable

activity.labels <- c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", 
                     "5" = "STANDING", "6" = "LAYING")
summary.data$Activity <- revalue(summary.data$Activity, activity.labels)

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject
### final dataframe is 180 rows (30*6) and 68 columns (66+2)

subject.activity <- group_by(summary.data, Subject, Activity)
tidy.data <- summarise_each(subject.activity, funs(mean))

write.table(tidy.data, "tidy.txt", row.name=FALSE)

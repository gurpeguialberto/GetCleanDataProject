
#Getting and Cleaning Data. Course Project.  
##Codebook.md  

**Author: gurpegui.alberto@gmail.com**

Codebook explaining variables and summaries *run_analysis.R* script uses.
See *README.md* file to get information about how that script works and the files and directories created by unziping requested file.   
Here you will find information about variables and any other relevant information.

These are the 5 pieces in which the code of the script is divided:

1 Merges the training and the test sets to create one data set.

Variable name |dimensions |Definition |Details (function/summary used to get it)    
------------------|-----------------|--------------------------------------|----------------------------------   
features |(561,2) |names of functions |`read.table("./UCI HAR Dataset/features.txt")`   
X_test |(2947,561) |test subset data |`read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])`   
X_train |(7352,561) |train subset data |`read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])`    
X |(10299,561) |merge of both previous |`rbind(X_test, X_train)`   

2 Extracts only the measurements on the mean and standard deviation for each measurement. 

Variable name |dimensions |Definition |Details (function/summary used to get it)    
------------------|-----------------|--------------------------------------|---------------  
requestedFeatures |(66,2) |names of functions that contain *mean* or *std* |`features[grep("(mean\|std)\\\\(", features[,2]),]`   
mean_std |(10299,66) |subset from *X* which contain the previous names |`X[,requestedFeatures[,1]]`   

3 Uses descriptive activity names to name the activities in the data set.   

Variable name |dimensions |Definition |Details (function/summary used to get it)    
------------------|-----------------|--------------------------------------|----------   
y_test |(2947,1) |activity number/code for test |`read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))`   
y_train |(7352,1) |activity number/code for train |`read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))`   
y |(10299,1) |merge of both previous |`rbind(y_test, y_train)`
y (updated) |(10299,1) |changed codes by names |loop for

4 Appropriately labels the data set with descriptive activity names.   

Variable name |dimensions |Definition |Details (function/summary used to get it)    
------------------|-----------------|--------------------------------------|-------------   
labels |(10299,562) |column with activity + *X*  |`bind(y, X)`
mean_std_labels |(10299,67) |column with activity + *mean_std* |`cbind(y, mean_std)`

5 Creates a second, independent tidy data set with the average of each variable.   

Variable name |dimensions |Definition |Details (function/summary used to get it)    
------------------|-----------------|--------------------------------------|-------------    
subject_test |(2947,1) |code for subjects |`read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))`
subject_train |(7352,1) |code for subjects |`rbind(subject_test, subject_train)`
subject |(10299,1) |merge both previous |`read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))`
averages |(180,563) |final **tidy data** requested |`aggregate(X, by = list(activity = y[,1], subject = subject[,1]), mean)`




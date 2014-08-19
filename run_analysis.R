run_analysis <- function(){
      # See README.md for how this script works in detail.
      # See Codebook.md for descriptions of the variables here used in detail.
      
      # If 'UCI HAR Dataset' directory doesn't exist, download 'zip' file and unzip it.
      # Be sure that a 59.7 Mb zip file is dowloaded completely.
      if (is.na(file.info("UCI HAR Dataset")$isdir)) {
            dataFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            dir.create("dataset_zip")
            download.file(dataFile, "dataset_zip/UCI-HAR-dataset.zip", method="auto")
            unzip("dataset_zip/UCI-HAR-dataset.zip")
      }
      # Now it must exist a directory 'dataset_zip with the zip file downloaded.
      # and a 'UCI HAR Dataset' directory with the unzipped files used by this script.
      
      # 1. Merges the 'training' and the 'test' sets to create one data set.
      ##Uses 'features' as column names for both 'X' 'test' and  'train'.
      features <- read.table("./UCI HAR Dataset/features.txt")
            #(561,2) table (read 'table' as 'data frame')
            #Uses names contained into 2nd col,  as column names for 'X_?' (561). 
      X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
            ##(2947,561) table
      X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
            ##(7352,561) table
      X <- rbind(X_test, X_train)
            ##(10299,561) table
      
      # 2. Extracts only the measurements on the 'mean' and 'standard deviation' for each measurement. 
      ## Notice that 'features' is a (561,2) table
      requestedFeatures <- features[grep("(mean|std)\\(", features[,2]),]
            ### (66,2) table
      mean_std <- X[,requestedFeatures[,1]]
            ### (10299,66) table
      
      
      # 3. Uses descriptive activity names to name the activities in the data set
      y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
            ### (2947,1) table
      y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
            ### (7352,1) table
      y <- rbind(y_test, y_train)
            ### (10299,1) table
      
      labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
            ### (6,2) table
      for (i in 1:nrow(labels)) {
            code <- as.numeric(labels[i, 1])
            name <- as.character(labels[i, 2])
            y[y$activity == code, ] <- name
      }
      #Each number of an activity has been changed with its descriptive readable name
      
      # 4. Appropriately labels the data set with descriptive activity names. 
      X_labels <- cbind(y, X)
            ### (10299,562) Column 'activity was added at first col.
      mean_std_labels <- cbind(y, mean_std)
            ### (10299,67) table. Column 'activity was added at first col.
     
      
      # 5. Creates a second, independent tidy data set with the average of each variable 
      #    for each activity and each subject. 
      subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
            ### (2947,1) table
      subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
            ### (7352,1) table
      subject <- rbind(subject_test, subject_train)
            ### (10299,1) table 
      ## method for class 'data.frame':
      #     'by' is a list of grouping elements, each as long as the variables in the data frame x
      #           aggregate(x, by, FUN, ..., simplify = TRUE)
      averages <- aggregate(X, by = list(activity = y[,1], subject = subject[,1]), mean)
            ## 
            ### (180,563) table . Final tidy data set.
      
      write.table(averages, file="averages.txt", row.names=FALSE)
}
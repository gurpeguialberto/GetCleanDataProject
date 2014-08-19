##GETTING AND CLEANING DATA. COURSE PROJECT.
###README.md
Here you will find how *run_analysis.R* script works.   
**NOTE**: the unique function that contain this script is called *run_analysis()* too, without parameters.      
**USE** `run_analysis()` and get *averages.txt* file in your working directory, that is the **tidy data set**. Please, if you want to read it, **load it** with `read.table()` function.

**Author: gurpegui.alberto@gmail.com **   
GitHub repository: [https://github.com/gurpeguialberto/GetCleanDataProject](https://github.com/gurpeguialberto/GetCleanDataProject)   

Project elements:  

File |Where it is |Details   
----------------|----------------------|----------------------------------------------   
run_analysis.R |GitHub |R script file.      
README.md |GitHub |Markdown file explaining the *run_analysis.R* script. **This file**.  
averages.txt |coursera submitting project site |It's the output of *run_analysis.R* (text file: `write.table()` function and argument `row.names' = FALSE`.   
Codebook.md |GitHub |Markdown file indicating all the variables and summaries calculated, along with dimensions, and any other relevant information, more in depth.   

###Script flow.   
This R script called *run_analysis.R* must do (project specifications): 

1 Merges the training and the test sets to create one data set.   
2 Extracts only the measurements on the mean and standard deviation for each measurement.  
3 Uses descriptive activity names to name the activities in the data set.  
4 Appropriately labels the data set with descriptive activity names.  
5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. The 'second' data set and what will be responsed.  

###My approach:

In order to accomplish **first requirement** , downloads the dataset: if not present, creates a new directory named *dataset_zip*. Here stores the *UCI-HAR-dataset.zip* file downloaded.
Unzip *UCI-HAR-dataset.zip* file in working directory: a new directory *UCI HAR Dataset* is created containing 4 txt files and 2 folders, namely *test* (with 2 txt) and *train* (2 txt) :
- activity_labels.txt    
- features.txt   
- features_info.txt  
- README.txt. Here you will find this and further information.
- train/X_train.txt: Training set.
- train/y_train.txt': Training labels.
- test/X_test.txt: Test set.
- test/y_test.txt: Test labels.

Merges with rbind the *training and test* sets (files). *X* is a new (10299,561) data frame.

To carry out **second requirement**, takes *std* and *mean* features. Creates a *requestedFeatures* variable with these requested features. They results in a (66,2) data frame with the original rows in the first column, and the name (that contain "mean" or "std" in its name) of the features in the second.
Then subset the *X* dataset with this 66 features ; the result is at *mean_std* variable: a (10299,66) data frame.  

**Third requirement**, loads the *activity labels*, and replace each index with names. 
First rbind both *y train and test* files: *y* result a (10299,1) data frame with only numbers/codes of each activity. Then reads *activity_labels.txt* and stores it in *labels* variable, a (6,2) data frame. A loop over these 6 rows, changes each row of *y* (a number/code that means an activity) by its readable name contained in *label*. *y* results in a (10299,1) data frame, which column is that readable activity.  

**Fourth requirement**, combines the labels at *y* (10299,2), and the data set *X* (10299,561), using `cbind()`. Results a (10299,562) data frame stored at *X_labels*.   
Exactly the same with *y* it's added to *mean std* (that is a (10299,66) data frame). Results a (10299,67) stored at *mean_std_labels* variable.
**Fifth requirement**, fist combines at *subject* both *subject train and test* files. Results a (10299,1) data frame. Then using the *X*, calculates an aggregate using mean for *averaging*, averaging over *activity* and *subject* with `aggregate()` function and the parameters `by = list(activity = y[,1], subject = subject[,1])` and function `mean`.
Finally saves the output to a file named *averages.txt*, a (180,563) data frame as *final tidy data set*.
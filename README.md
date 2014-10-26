## Getting and Cleaning Data Course Project
This repository contains the completed R script, run_analysis.R, for Getting and Cleaning Data Course Project.

### Completed R Code
The completed R code for this assignment is contained in one single run_analysis.R file at the root of this repository.

The run_analysis.R is separated into 5 parts:
* Step 1 - Read the training and test data. Subsequently merge them into one single data set.
* Step 2 - Extract only the variables which contain the mean and standard deviation of the measurements.
* Step 3 - Use descriptive activity label in the activity column.
* Step 4 - Update the variable name of each column to make them more descriptive.
* Step 5 - Create a new tidy data set that contains the average of each variable for each activity and each subject.

### Installing Packages
Before you run the R script, you might need to install the plyr and Hmisc R pacakges.

### Location of data files
It is assumed that the test and training data files are located in the subfolder "UCI HAR Dataset" of the working directory. You might need to set your working directory to where the folder "UCI HAR Dataset" is located.

### Running the R Script
To run the R code, make sure that the run_analysis.R is located in your working directory. Then perform source("run_analysis.R"), an output file TidyData.txt will be created containing the result data set.

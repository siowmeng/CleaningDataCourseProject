library(plyr)
library(Hmisc)

## Step 1 - Read in Training and Test subjects from files and merged them into one data frame MergedData
## Intertial Signals are omitted since they do not contain Mean and Standard Deviation measurements

SubTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
SubTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
MergedData <- rbind(SubTest, SubTrain)

YTest <-  read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity")
YTrain <-  read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity")
YMerge <- rbind(YTest, YTrain)
MergedData$activity <- YMerge$activity

FeatureLabel <- read.table("./UCI HAR Dataset/features.txt", col.names = c("sequence", "feature"))
XTest <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = FeatureLabel$feature)
XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = FeatureLabel$feature)
XMerge <- rbind(XTest, XTrain)
MergedData <- cbind(MergedData, XMerge)

## Step 2 - Extract only the measurement columns which contain mean() and std(), since the Mean and Standard Deviation measurement columns will have either of these two strings

FeatureLabel$wanted <- (grepl("std[(][)]", FeatureLabel$feature) | grepl("mean[(][)]", FeatureLabel$feature))
WantedColumns <- c(TRUE, TRUE, FeatureLabel$wanted)
MergedData <- MergedData[, WantedColumns]

## Step 3 - Replace the value in activity column with the 6 activity labels

ActLabel <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("value", "label"))
MergedData$activity <- cut(MergedData$activity, breaks = 6, labels = ActLabel$label)

## Step 4 - For those column names being read in during read.table, remove the dot characters

names(MergedData) <- gsub("[.](mean|std)[.][.]", "\\1", names(MergedData))
names(MergedData) <- gsub("[.]([XYZ])", "\\1", names(MergedData))

## Step 5 - Create a new data frame TidyData which contains the average of each variable for each activity and each subject

TidyData <- ddply(MergedData, .(subject, activity), summarise, AveTBodyAccMeanX=mean(tBodyAccmeanX), AveTBodyAccMeanY=mean(tBodyAccmeanY), AveTBodyAccMeanZ=mean(tBodyAccmeanZ), AveTBodyAccStdX=mean(tBodyAccstdX), AveTBodyAccStdY=mean(tBodyAccstdY), AveTBodyAccStdZ=mean(tBodyAccstdZ), AveTGravityAccMeanX=mean(tGravityAccmeanX), AveTGravityAccMeanY=mean(tGravityAccmeanY), AveTGravityAccMeanZ=mean(tGravityAccmeanZ), AveTGravityAccStdX=mean(tGravityAccstdX), AveTGravityAccStdY=mean(tGravityAccstdY), AveTGravityAccStdZ=mean(tGravityAccstdZ), AveTBodyAccJerkMeanX=mean(tBodyAccJerkmeanX), AveTBodyAccJerkMeanY=mean(tBodyAccJerkmeanY), AveTBodyAccJerkMeanZ=mean(tBodyAccJerkmeanZ), AveTBodyAccJerkStdX=mean(tBodyAccJerkstdX), AveTBodyAccJerkStdY=mean(tBodyAccJerkstdY), AveTBodyAccJerkStdZ=mean(tBodyAccJerkstdZ), AveTBodyGyroMeanX=mean(tBodyGyromeanX), AveTBodyGyroMeanY=mean(tBodyGyromeanY), AveTBodyGyroMeanZ=mean(tBodyGyromeanZ), AveTBodyGyroStdX=mean(tBodyGyrostdX), AveTBodyGyroStdY=mean(tBodyGyrostdY), AveTBodyGyroStdZ=mean(tBodyGyrostdZ), AveTBodyGyroJerkMeanX=mean(tBodyGyroJerkmeanX), AveTBodyGyroJerkMeanY=mean(tBodyGyroJerkmeanY), AveTBodyGyroJerkMeanZ=mean(tBodyGyroJerkmeanZ), AveTBodyGyroJerkStdX=mean(tBodyGyroJerkstdX), AveTBodyGyroJerkStdY=mean(tBodyGyroJerkstdY), AveTBodyGyroJerkStdZ=mean(tBodyGyroJerkstdZ), AveTBodyAccMagMean=mean(tBodyAccMagmean), AveTBodyAccMagStd=mean(tBodyAccMagstd), AveTGravityAccMagMean=mean(tGravityAccMagmean), AveTGravityAccMagStd=mean(tGravityAccMagstd), AveTBodyAccJerkMagMean=mean(tBodyAccJerkMagmean), AveTBodyAccJerkMagStd=mean(tBodyAccJerkMagstd), AveTBodyGyroMagMean=mean(tBodyGyroMagmean), AveTBodyGyroMagstd=mean(tBodyGyroMagstd), AveTBodyGyroJerkMagMean=mean(tBodyGyroJerkMagmean), AveTBodyGyroJerkMagStd=mean(tBodyGyroJerkMagstd), AveFBodyAccMeanX=mean(fBodyAccmeanX), AveFBodyAccMeanY=mean(fBodyAccmeanY), AveFBodyAccMeanZ=mean(fBodyAccmeanZ), AveFBodyAccStdX=mean(fBodyAccstdX), AveFBodyAccStdY=mean(fBodyAccstdY), AveFBodyAccStdZ=mean(fBodyAccstdZ), AveFBodyAccJerkMeanX=mean(fBodyAccJerkmeanX), AveFBodyAccJerkMeanY=mean(fBodyAccJerkmeanY), AveFBodyAccJerkMeanZ=mean(fBodyAccJerkmeanZ), AveFBodyAccJerkStdX=mean(fBodyAccJerkstdX), AveFBodyAccJerkStdY=mean(fBodyAccJerkstdY), AveFBodyAccJerkStdZ=mean(fBodyAccJerkstdZ), AveFBodyGyroMeanX=mean(fBodyGyromeanX), AveFBodyGyroMeanY=mean(fBodyGyromeanY), AveFBodyGyroMeanZ=mean(fBodyGyromeanZ), AveFBodyGyroStdX=mean(fBodyGyrostdX), AveFBodyGyroStdY=mean(fBodyGyrostdY), AveFBodyGyroStdZ=mean(fBodyGyrostdZ), AveFBodyAccMagMean=mean(fBodyAccMagmean), AveFBodyAccMagStd=mean(fBodyAccMagstd), AveFBodyBodyAccJerkMagMean=mean(fBodyBodyAccJerkMagmean), AveFBodyBodyAccJerkMagStd=mean(fBodyBodyAccJerkMagstd), AveFBodyBodyGyroMagMean=mean(fBodyBodyGyroMagmean), AveFBodyBodyGyroMagStd=mean(fBodyBodyGyroMagstd), AveFBodyBodyGyroJerkMagMean=mean(fBodyBodyGyroJerkMagmean), AveFBodyBodyGyroJerkMagStd=mean(fBodyBodyGyroJerkMagstd))

## Write TidyData into a file
write.table(TidyData, "./TidyData.txt", row.names = FALSE)

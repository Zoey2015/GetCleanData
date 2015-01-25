# GetCleanData
Part I: Merges the training and the test sets to create one data set.
Including:
Library(read.table）
Functions: read.table, merge, cbind, paste

Part II and III and IV: Extracts only the measurements on the mean and standard deviation for each measurement. 
,Uses descriptive activity names to name the activities in the data set 
,Appropriately labels the data set with descriptive variable names.
Including:
Library(reshape2）
Functions: read.table, subset, grep, sort, melt, gsub

Part V: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Including:
Functions:write.table

##1.Merges the training and the test sets to create one data set.
Data_Merge()<-function(){
  #preparation:use read.table library and get the directory;
    library (read.table)
    dir<-getwd()
  #read in X_test and X_train;
    path <- paste(dir, "/test/X_test.txt", sep="")
    test_data <- read.table(path)
    path <- paste(dir, "/train/X_train.txt", sep="")
    train_data <- read.table(path)
  #read in y_test and y_train;
    path <- paste(dir, "/train/y_train.txt", sep="")
    y_train <- read.table(path)
    path <- paste(dir, "/test/y_test.txt", sep="")
    y_test <- read.table(path)
  #read in activity label; 
    path <- paste(dir, "/activity_labels.txt", sep="")
    activity_labels <- read.table(path)
  #read in subject dataset;   
    path <- paste(dir, "/train/subject_train.txt", sep="")
    subject_train <- read.table(path)
    path <- paste(dir, "/test/subject_test.txt", sep="")
    subject_test <- read.table(path)
  #import labels; 
    y_train_labels <- merge(y_train,activity_labels,by="V1")
    y_test_labels <- merge(y_test,activity_labels,by="V1")
  #binding data with labels;  
    train_data <- cbind(subject_train,y_train_labels,train_data)
    test_data <- cbind(subject_test,y_test_labels,test_data)
  #finally, merging all data together; 
    dataset <- rbind(train_data,test_data)
    return (all_data)
}

##2.Extracts only the measurements on the mean and standard deviation for each measurement. 
    path <- paste(dir, "/features.txt", sep="")
    features_data <- read.table(path)
 #subset mean/standard deviation 
    mean_std <- subset(features_data,grepl("(mean\\(\\)|std\\(\\))", features_data$V2))
 #set column name and put mean/std data together
    colnames(dataset) <- c("Subject","Activity_Id","Activity",as.vector(features_data[,2]))
    mean_columns <- grep("mean()", colnames(dataset), fixed=TRUE)
    std_columns <- grep("std()", colnames(dataset), fixed=TRUE)
    mean_std_column_vector <- sort(c(mean_columns, std_columns))
    extracted_data_set <- dataset[,c(1,2,3,mean_std_column_vector)]

##3.Uses descriptive activity names to name the activities in the data set  
    require(reshape2)
    mdata <- melt(dataset, id=c("Subject","Activity_Id","Activity"))
    tidy_data <- dcast(mdata, formula = Subject + Activity_Id + Activity ~ variable, mean)

##4.Appropriately labels the data set with descriptive variable names    
    col_names <- colnames(tidy_data)
    col_names <- gsub("-mean()","Mean",col_names_vector,fixed=TRUE)
    col_names <- gsub("-std()","Std",col_names_vector,fixed=TRUE)
    col_names <- gsub("BodyBody","Body",col_names_vector,fixed=TRUE)   
    colnames(tidy_data) <- col_names
##5.From the data set in step 4, creates a second, independent tidy data
## set with the average of each variable for each activity and each subject.  
    path <- paste(dir, "/tidy.txt", sep="")
    write.table(tidy_data, file=path, sep="\t", row.names=FALSE)



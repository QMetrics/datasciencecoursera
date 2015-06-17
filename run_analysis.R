run_analysis <- function(){
  
  library(dplyr)
  
  ## 1. Merges the training and the test sets to create one data set:
  ## Merge training and test dataset, by first reading the actual datasets
  
  X_train <-read.table("./train/X_train.txt")
  X_test <-read.table("./test/X_test.txt")
  
  ## Then merge the two datasets into a total dataset
  X_total <- rbind(X_train,X_test)
  
  ## Use the file feature.txt to name the column names of X_Total
  
  ## Read the "features.txt" file
  names_columns_X<-read.table("./features.txt")
  
  ## Change the column names of X_total to the data from "features.txt"
  names(X_total)<-names_columns_X[,2]

  
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  ## To extract only the measurements on the mean and standard devation, the grep() function will 
  ## be used to end up with a vector (meanstdVector) containing the columns with mean() and std().

  meanstdVector <- grep("mean|std", names(X_total))
  
  X_total <- X_total[,meanstdVector]
  ## Furthermore, meanfreq is not actually a mean so these columns need to be excluded
  
  meanfreqVector<-grep("meanFreq", names(X_total))
  
  X_total<-X_total[,-meanfreqVector]  

  
  ## 3. Uses descriptive activity names to name the activities in the data set:
  ## The "y_train" and "y_test" datasets contain the activity codes. These codes have to be joined 
  ## with the "activity_labels" to get the activity names.
  
  ## Read "y_train" and "y_test" and merge them
  Y_train<-read.table("./train/y_train.txt")
  Y_test<-read.table("./test/y_test.txt")
  Y_total<-rbind(Y_train,Y_test)
  ## Rename the column name
  Y_total<-rename(Y_total,ActivityCode=V1)
  
  ## Read the "activity_labels.txt" file
  activity_labels<-read.table("./activity_labels.txt")
  # rename the names in activity labels for a better understanding
  activity_labels<-rename(activity_labels, ActivityCode=V1, ActivityName=V2)
  
  ## join Y_total with activity_labels
  ActivityVector<-merge(Y_total,activity_labels, by="ActivityCode")
  ## Then add this ActivityVector to X_total
  X_total<-cbind(X_total,ActivityName = ActivityVector$ActivityName)

  ## 4. Appropriately labels the data set with descriptive variable names
  ## The names contains "Acc", "Gyro" and "Mag". Change them respectively into "Accelerator", 
  ## "Gyroscope" and "Magnitude".
  
  names(X_total) <- gsub("Acc", "Accelerator", names(X_total))
  names(X_total) <- gsub("Mag", "Magnitude", names(X_total))
  names(X_total) <- gsub("Gyro", "Gyroscope", names(X_total))
  
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the 
  ## average of each variable for each activity and each subject.
  ## First, add the subjects to X_total. This can be done by first merging "subject_train" and ##
  ## "subject_test".
  
  subject_train<-read.table("./train/subject_train.txt")
  subject_test<-read.table("./test/subject_test.txt")
  ## Add them together
  subject_total<-rbind(subject_train,subject_test)
  
  ## Rename the column name
  subject_total<-rename(subject_total, Subject=V1)
  
  ## Add this to X_total and name this TotalTidyData
  TotalTidyData<-cbind(X_total,subject_total)
  
  ## To calculate the mean of all combinations of Activity and Subject, we
  ## have to group by Activity and Subject First
  Group_By_TotalTidyData<-group_by(TotalTidyData,Subject,ActivityName)
  
  ##Calculate the means of all variables for all combinations of Activity and Subject
  MeansOfTidyData<-summarise_each(Group_By_TotalTidyData, funs(mean), -ActivityName)
  
  ## Write the Tidy Data in txt file
  write.table(MeansOfTidyData, file="TidyData.txt", sep=" ")
  return(MeansOfTidyData)
}
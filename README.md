
# Context
This README file regards to the course project of "Getting and Cleaning data" of the specialization of "Data Science".
This README file describes the datasets, transformations of these data to get to a tidy dataset.

# Dataset
The total dataset consists of the following data:

- 'features.txt': List of all features. This file contains the column names of "X_train.txt" and "X_test.txt".

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Train lables. This dataset contains a vector with integers from 1 to 6 corresponding to the activities.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels. This dataset contains a vector with integers from 1 to 6 corresponding to the activities.

The following file is available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.


# Obtaining a tidy dataset

In general, the following steps will be executed to come to a tidy dataset:
	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

**Merges the training and the test sets to create one data set:** 

Before being able to merge the training and test sets, these two sets will be read in R first, X_train and X_test. 
Merge X_train and X_test by "rbind". The resulting dataframe is X_total.
In the next step use the file "features.txt" to name the column names of X_total.

**Extracts only the measurements on the mean and standard deviation for each measurement:** 

To extract only the measurements on the mean and standard devation, the grep() function will be used to end up with a vector
(meanstdVector) containing the columns with mean() and std().
Furthermore, meanfreq is not actually a mean so these columns need to be excluded.


**Uses descriptive activity names to name the activities in the data set:** 

The "y_train" and "y_test" datasets contain the activity codes. These codes have to be joined with the "activity_labels" to get the activity names.
The joining results in a vector, ActivityVector. Add the ActivityVector to X_total.

**Appropriately labels the data set with descriptive variable names:** 

The names contains "Acc", "Gyro" and "Mag". Change them respectively into "Accelerator", "Gyroscope" and "Magnitude".

**From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:**
First, add the subjects to X_total. This can be done by first merging "subject_train" and "subject_test". The final data will be grouped by subject and activity. After that the means will 
be calculated.
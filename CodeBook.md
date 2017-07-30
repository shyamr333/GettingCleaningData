# CodeBook

# Analysis

**Step 1:** First, I imported the training and test set data (`X_train.txt,``X_test.txt`,`subject_train.txt`, `y_train.txt`,`y_test.txt`,`subject_test.txt`). I also imported `activity_labels.txt`, which has the labels for the 6 activities and `features.txt`, which contained the names/labels of feature variables.

**Step 2:** I assigned variable names to columns in the training and test sets by using data from `features.txt`.  

**Step 3:** Using `grepl()` and the `|` operator, I extracted only the measurements related to the mean and standard deviation for each measurement.

**Step 4:** I used descriptive activity names to name the activities in the data set. Activity names were taken from `activity_labels.txt`

**Step 5:** Using `gsub()` , I changed the variable names so that they could be more descriptive.

**Step 6:** Using the `aggregate()` function from the `plyr` package, I created a separate tidy data set with the average of each variable/feature for each activity and each subject. This tidy dataset was written to the file `averagedData.txt`.

# Variables used in the code

`X_train` and `X_test` contain the values of the feature variables for each observation
`y_train` and `y_test` contain the activity number for each observation
`subject_train` and `subject_test` contain the subject ID for each observation
`feature_names` contains the names/labels of the feature variables, whose values are there in `X_train` and `X_test`
`activity_names` contains the activity type/labels corresponding to activity numbers
`merged_train` has all the data for the training set in one dataset. It was created by using `cbind()` on `X_train`, `y_train` and `subject_train`
`merged_test` has all the data for the testing set in one dataset. It was created by using `cbind()` on `X_test`, `y_test` and `subject_test`
`combined` was created using `rbind()` on `merged_train` and `merged_test`
`final_dataset` has only the relevant columns (means and standard deviations of the measurements) and also has the Activity types instead of the activity numbers. The activity types was taken from `activity_labels.txt`
`averaged_data` is the tidy dataet created in step 6, which was ultimately written to `averagedData.txt`

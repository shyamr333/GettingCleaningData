# CodeBook

# Analysis

**Step 1:** First, I imported the training and test set data, along with the file containing the labels for the activities and the labels for the feature variables. I subsequently merged the training and test sets into one data set.

**Step 2:** Using `grepl()` and the `|` operator, I extracted only the measurements related to the mean and standard deviation for each measurement

**Step3:** I used descriptive activity names to name the activities in the data set. Activity names were taken from `activity_labels.txt`

**Step4:** Using `gsub()` , I changed the variable names so that they could be more descriptive

**Step5:** Using the `aggregate()` function from the `plyr` package, I created a separate tidy data set with the average of each variable/feature for each activity and each subject.

**Step6:** Finally, I generated a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called averagedData.txt, and uploaded to this repository.

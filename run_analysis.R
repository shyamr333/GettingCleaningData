library(plyr)

#create a subdirectory called Data if it does not already exists

if(!file.exists("./data")){dir.create("./data")}

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(URL, destfile = "./data/Data.zip")

unzip(zipfile="./data/Data.zip",exdir="./data")


#read the required files
#X_train and X_test contain the values of the feature variables for each observation
#y_train and y_test contain the activity number for each observation
#subject_train and subject_test contain the subject ID for each observation
#feature_names contains the names/labels of the feature variables
#activity_names contains the activity type/labels corresponding to activity numbers


X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

feature_names <- read.table("./data/UCI HAR Dataset/features.txt")
activity_names <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#assigning column names

colnames(X_train) <- feature_names[,2]
colnames(X_test) <- feature_names[,2]
colnames(y_train) <- "ActivityNumber"
colnames(y_test) <- "ActivityNumber"
colnames(subject_train) <- "subjectID"
colnames(subject_test) <- "subjectID"
colnames(activity_names) <- c("ActivityNumber", "ActivityType")

#merging the training and test sets

merged_train <- cbind(X_train, y_train, subject_train)
merged_test <- cbind(X_test, y_test, subject_test)
combined <- rbind(merged_train, merged_test)

#Extracts only the measurements on the mean and standard deviation for each measurement.

column_names <- colnames(combined)

relevant_cols <- grepl("-mean\\(\\)",column_names)|grepl("-std\\(\\)", column_names)|grepl("ActivityNumber",column_names)|grepl("subjectID", column_names)

combined <- combined[,relevant_cols]

#linking the activity types with the numbers

final_dataset <- merge(combined, activity_names, by = "ActivityNumber", all.x = TRUE)

#remove the activity number column i.e. the first column

final_dataset <- final_dataset[,2:69]

#improving variable names to be more descriptive

names(final_dataset) <- gsub("^t","time", names(final_dataset))
names(final_dataset) <- gsub("^f", "frequency", names(final_dataset))
names(final_dataset) <- gsub("Gyro", "Gyroscope", names(final_dataset))
names(final_dataset) <- gsub("Acc", "Accelerometer", names(final_dataset))
names(final_dataset) <- gsub("Mag", "Magnitude", names(final_dataset))
names(final_dataset) <- gsub("BodyBody", "Body", names(final_dataset))

#creates a second, independent tidy data set with the average of each variable for each activity and each subject

averaged_data <- aggregate(.~ subjectID + ActivityType, final_dataset, mean)
averaged_data <- averaged_data[order(averaged_data$subjectID, averaged_data$ActivityType),]

#writing this averaged and tidy data to a new file

write.file(averaged_data , file = "averagedData.txt", row.name = FALSE)

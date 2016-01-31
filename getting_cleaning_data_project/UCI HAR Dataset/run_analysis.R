# Clean up workspace
rm(list=ls())

#set working directory to the location where the UCI HAR Dataset was unzipped
setwd('C:\\Users\\kumail\\OneDrive\\coursera\\Coursera\\getting and cleaning data\\course project\\getting_cleaning_data_project\\UCI HAR Dataset');

#Reading in the features datatable for both "test" and "train" cases.
features_test_DT <- read.table("test/X_test.txt")
features_train_DT <- read.table("train/X_train.txt")

#Assigning appropriate variable names to the features datatable for both "test" and "train" cases.
features_colnames<- read.table("features.txt")
features_variables <- features_colnames$V2
features_variables <- as.character(features_variables)
colnames(features_test_DT) <- features_variables
colnames(features_train_DT) <- features_variables

#Extracting only the measurements on the mean and standard deviation for each measurement. 
bool1 <- grepl("mean()", features_variables)
bool2 <- grepl("std()", features_variables)
bool <- bool1 | bool2
features_variables <- features_variables[bool]
features_variables<- as.character(features_variables)
bool3 <- grepl("meanFreq()", features_variables)
features_variables <- features_variables[!bool3]
features_test_DT <- features_test_DT[features_variables]
features_train_DT <- features_train_DT[features_variables]

#Merging the relevant parts of the training and the test sets to create one data set.
HAR_DS <- data.frame()
performerID_test <- read.table("test/subject_test.txt")
activityID_test <- read.table("test/y_test.txt")
performerID_train <- read.table("train/subject_train.txt")
activityID_train <- read.table("train/y_train.txt")
HAR_test <- data.frame("performerID"=performerID_test, "activityID"=activityID_test)
colnames(HAR_test) <- c("PerformerID", "ActivityID")
HAR_test <- cbind(HAR_test, features_test_DT)
HAR_train <- data.frame("performerID"=performerID_train, "activityID"=activityID_train)
colnames(HAR_train) <- c("PerformerID", "ActivityID")
HAR_train <- cbind(HAR_train, features_train_DT)
HAR_DS <- rbind(HAR_DS, HAR_train)
HAR_DS <- rbind(HAR_DS, HAR_test)

#Uses descriptive activity names to name the activities in the data set
HAR_DS$ActivityID <- as.character(HAR_DS$ActivityID)
HAR_DS$ActivityID[HAR_DS$ActivityID == "1"] <- "WALKING"
HAR_DS$ActivityID[HAR_DS$ActivityID == "2"] <- "WALKING_UPSTAIRS"
HAR_DS$ActivityID[HAR_DS$ActivityID == "3"] <- "WALKING_DOWNSTAIRS"
HAR_DS$ActivityID[HAR_DS$ActivityID == "4"] <- "SITTING"
HAR_DS$ActivityID[HAR_DS$ActivityID == "5"] <- "STANDING"
HAR_DS$ActivityID[HAR_DS$ActivityID == "6"] <- "LAYING"

average_variables <- ddply(HAR_DS, .(HAR_DS$PerformerID, HAR_DS$ActivityID), function(x) colMeans(x[, 3:68]))

write.table(average_variables, "average_variables.txt", row.name=FALSE)
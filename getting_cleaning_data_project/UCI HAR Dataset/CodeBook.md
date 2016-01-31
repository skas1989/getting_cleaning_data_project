Code Book
==========

Variables
---------
+ The dataset contains measurements made from the accelerometers from the Samsung Galaxy S smartphone. All the measurements initially are designated as training data or test data. 
+ We read in the training and test data from X_train.txt and X_test.txt respectively and named the resulting dataframes "features_train_DT" "features_test_DT"
+ Variable/Column names are given in features.txt. We use the names in features.txt to label each column of the "features_train_DT" "features_test_DT" dataframes.
+ We extracted only the measurements on the mean and standard deviation for each measurement using boolean logics, i.e. keeping 66 variables out of 561 variables in both the "features_train_DT" "features_test_DT" dataframes. 
+ We read in the "performer" and "activity" data for both the "training" and "test" datasets from the following files respectively - "subject_train.txt" "y_train.txt" "subject_test.txt" "y_test.txt".
+ Created empty dataframes called HAR_train, HAR_test. We merged the "performer" and "activity" data for both the "training" and "test" datasets into the HAR_train, HAR_test dataframes.
+ We used Cbind to merge the "features_train_DT" dataframe with "HAR_DS_train" dataframe
+ Similary, we used Cbind to merge the "features_test_DT" dataframe with "HAR_DS_test" dataframe
+ Merged the "HAR_DS_test" and "HAR_DS_train" dataframes using rbind to form one dataframe called HAR_DS.
+ Used descriptive activity names to name the activities in the data set.
+ Created a second, independent tidy data set with the average of each variable for each subject/activity combination
# CODEBOOK FOR run_analysis.R
Peer Graded Assignment Getting and Cleaning Data Coursera Project

## SUMMARY:
This document describes the code inside run_analysis.R, which can be used to summarize data collected from Samsung Galazy S smartphone readings prepared as descripbed in:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

More information on the experiment and data sources can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Sample datasets and formats required for the analysis can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Move the datasets in the list below to your working directory.

## OBJECTIVE:
The goal was to create a tidy dataset grouped by subject and activity summarizing the average of each of mean and standard deviation variable.

## DATA FILES NEEDED IN WORKING DIRECTORY:
- 'features_info.txt'     - Information about the variables used 
- 'features.txt'          - A 561-feature vector with time and frequency domain variables.  561 variables in X datasets).
- 'activity_labels.txt'   - Links the class labels with their activity name.
- 'train/X_train.txt'     - Training set.(Accelerometer and Gyroscope Data with 561 Variables)
- 'test/X_test.txt'       - Test set.  (Accelerometer and Gyroscope Data with 561 Variables)
- 'train/y_train.txt'     - Training row labels.
- 'test/y_test.txt'       - Test row labels.
- 'subject_train.txt'     - Subject identifiers in training dataset
- 'subject_test.txt'      - Subject identifiers in test dataset

## METHODOLOGY FOR CREATING TIDY DATASET:
-	The code first checks for packages that are needed for the analysis
   - If packages aren’t installed then they are installed; 
   -	If packages are installed, they are loaded

-	Datasets listed above are loaded into R.
   -	Some columns are renamed on load:
     -	Column names in featuers.txt are given name “FeatureCode” and “Feature”  (FeatureCode is Column; Feature is name of each of the 561 variables in the x datasets.  See variables).
     -	Column names in activity_labels.text are given name “ActivityCode” and “Activity”  (Activity is name of activity that matches a specific “Activity Code” used in the x datasets.  See variables).
     -	Column name in y_train and y_test is labeled “ActivityCode” –this code matches Activity Code in activity_labels.text.  It will be used to join activity names with codes in x dataset.
     -	Column name in s_train and s_test is labeled “Subject” –since these are subject identifiers.

-	Datasets created are as follows:
  -	features = features.txt
  -	activity = activity_labels.txt
  -	xtrain = X_train.txt
  -	xtest = X_test.txt
  -	ytrain = Y_train.txt
  -	ytest = Y_test.txt
  -	strain = subject_train.txt
  -	stest = subject_test.txt

-	The column names in xtrain and xtest are renamed using the list of features (variable names) in features  (the column Features)

-	The Y datasets are annotated with activity names by merging y datasets with activity datasets.  

-	The x datasets are annotated with subject and activity by using cbind to join subject and activity with x datasets as follows:
  -	Data table syxtrain created by cbind of strain, ytrain, xtrain
  -	Data table syxtest created by cbind of stest, ytest, xtest

-	Each dataset (syxtrain and syxtest) are annotated with a variable called “Source” which indicates the original source (train or test) of the dataset.  This is done in case the data needs to be separated or analyzed by training or test sets later)

-	The two syxtrain and syxtest datasets are stacked using rbind to create a dataset called stack.

-	The features dataset is subset to include only those observations where Feature contains the words “-mean” or “-std” and not the words “-meanFreq”.  This is output to a dataframe called f.
  - A variable is created called f$column which takes into account that the original feature columns in the stack dataset are shifted over by 3 relative to the x datasets.
  - To add the names of the additional columns, a dataframe (called add) containing the columns in the dataset stack that are not featuers: “Subject”,”ActivityCode”,”Activity”,”Source” , which correspond to columns 1,2,3 and 565. 
  - The datafram add is added to the dataframe f to create a complete vector of columns we want to keep in stack.  (This vector is created from f$Column and is called keep)

-	A dataset called final is created that subsets the stack dataset to output only the mean and stdev columns (by using only the keep columns)

-	The variable names in final are modified to be more readable.
  - Gsub is used to add spaces in front of uppercase letters
  - Two vectors are created to allow substitutions as follows:
   - "t "  ="Time "
   - "f "  = Frequency "
   - "Acc "  ="Acceleration "
   - "Acc-"  ="Acceleration "
   - "Mag "  ="Magnitude "
   - "Mag-"  ="Magnitude "
   - "Gyro " ="Gyroscope "
   - "Gyro-" ="Gyroscope "
   - "mean"  ="Mean"
   - "std"  ="StdDev"
   - "\\(|\\)" =""
- Str_replace_all is used to assign names to columns where the replacements above are made

-	The final dataset tidydata is created by grouping the dataset called final by “Subject” and “Activity” and then using ddply to apply colMeans to the data in columns 5:70 (the mean and std variables from the original x datasets)

-	The dataset tidydata is written to the working directory (saved to a file called “ Average Sensor Signals By Subject and Activity.txt”

-	A message is displayed that tells the user that the dataset  “Average Sensor Signals By Subject and Activity.txt” has been written to the working directory.

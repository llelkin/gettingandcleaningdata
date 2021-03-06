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
| File                  |   File Description                                                                                 |
|-----------------------|----------------------------------------------------------------------------------------------------|
| 'features_info.txt'   |   Information about the variables used                                                             |
| 'features.txt'        |   A 561-feature vector with time and frequency domain variables.  561 variables in X datasets).    |
| 'activity_labels.txt' |   Links the class labels with their activity name.                                                 |
| 'train/X_train.txt'   |   Training set.(Accelerometer and Gyroscope Data with 561 Variables)                               |
| 'test/X_test.txt'     |   Test set.  (Accelerometer and Gyroscope Data with 561 Variables)                                 |
| 'train/y_train.txt'   |   Training row labels.                                                                             |
| 'test/y_test.txt'     |   Test row labels.                                                                                 |
| 'subject_train.txt'   |   Subject identifiers in training dataset                                                          |
| 'subject_test.txt'    |   Subject identifiers in test dataset                                                              |

## METHODOLOGY FOR CREATING TIDY DATASET:
1. The code first checks for packages that are needed for the analysis
   - If packages aren’t installed then they are installed; 
   - If packages are installed, they are loaded

2.	Datasets listed above are loaded into R.
     - Some columns are renamed on load:
       - Column names in featuers.txt are given name “FeatureCode” and “Feature”  (FeatureCode is Column; Feature is name of each of the 561 variables in the x datasets.  See variables).
       - Column names in activity_labels.text are given name “ActivityCode” and “Activity”  (Activity is name of activity that matches a specific “Activity Code” used in the x datasets.  See variables).
       - Column name in y_train and y_test is labeled “ActivityCode” –this code matches Activity Code in activity_labels.text.  It will be used to join activity names with codes in x dataset.
       - Column name in s_train and s_test is labeled “Subject” –since these are subject identifiers.

3.	Datasets created are as follows:

|Data Frame  |Original Data Source |
|--------------|-----------------------|
|features     |  features.txt         |
| activity     |  activity_labels.txt  |
| xtrain       |  X_train.txt          |
| xtest        |  X_test.txt           |
| ytrain       |  Y_train.txt          |
| ytest        |  Y_test.txt           |
| strain       |  subject_train.txt    |
| stest        |  subject_test.txt     |

4.	The column names in xtrain and xtest are renamed using the list of features (variable names) in features  (the column Features)

5.	The Y datasets are annotated with activity names by merging y datasets with activity datasets.  

6.	The x datasets are annotated with subject and activity by using cbind to join subject and activity with x datasets as follows:
     - Data table syxtrain created by cbind of strain, ytrain, xtrain
     - Data table syxtest created by cbind of stest, ytest, xtest

7.	Each dataset (syxtrain and syxtest) are annotated with a variable called “Source” which indicates the original source (train or test) of the dataset.  This is done in case the data needs to be separated or analyzed by training or test sets later)

8.	The two syxtrain and syxtest datasets are stacked using rbind to create a dataset called stack.

9.	The features dataset is subset to include only those observations where Feature contains the words “-mean” or “-std” and not the words “-meanFreq”.  This is output to a dataframe called f.
     - A variable is created called f$column which takes into account that the original feature columns in the stack dataset are shifted over by 3 relative to the x datasets.
     - To add the names of the additional columns, a dataframe (called add) containing the columns in the dataset stack that are not featuers: “Subject”,”ActivityCode”,”Activity”,”Source” , which correspond to columns 1,2,3 and 565. 
     - The dataframe add is added to the dataframe f to create a complete vector of columns we want to keep in stack.  (This vector is created from f$Column and is called keep)

10.  A dataset called final is created that subsets the stack dataset to output only the mean and stdev columns (by using only the keep columns)

11. The variable names in final are modified to be more readable.
     - Gsub is used to add spaces in front of uppercase letters
     - Two vectors are created to allow substitutions as follows:
     
     |Look For      |Substitution             |
     |--------------|-------------------------|
     |"t "          |  "Time "                |
     |"f "          |  "Frequency "           |
     | "Acc "       |  "Acceleration "        |
     | "Acc-"       |  "Acceleration "        |
     | "Mag "       |  "Magnitude "           |
     | "Mag-"       |  "Magnitude "           |
     | "Gyro "      |  "Gyroscope "           |
     | "Gyro-"      |  "Gyroscope "           |
     | "mean"       |  "Mean"                 |
     | "std"        |  "StdDev"               |
     | "()"         |  ""                     |
     
       - Str_replace_all is used to assign names to columns where the replacements above are made

12.	The final dataset tidydata is created by grouping the dataset called final by “Subject” and “Activity” and then using ddply to apply colMeans to the data in columns 5:70 (the mean and std variables from the original x datasets)

13.	The dataset tidydata is written to the working directory (saved to a file called “ Average Sensor Signals By Subject and Activity.txt”

14.	A message is displayed that tells the user that the dataset  “Average Sensor Signals By Subject and Activity.txt” has been written to the working directory.

## SUMMARY OF TIDY DATASET OUTPUT:
Data Frame:  40 Observations, 68 Variables

### VARIABLE SUMMARY:
|Column |  Variable Name | Variable Description  | Atomic Type | Possible Values |
|-------|----------------|-----------------------|-------------|-----------------|
|  1    |  Subject       | Subject Identifier    | Numeric     | 1:30            |
|  2    |  Activity      | Activity Descriptor   | Character   | Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing,Laying|
|3-68   |  *see below*   | Features*             | Numeric     | [-1,1]          |

*Note, columns 3-68 are features listed in features.txt. (mean and stdev features only)
Data for each feature is normalized and bounded within [-1,1].*

### VARIABLE DETAILS:
| Column #    |    Variable Name                          |
|-------------|-------------------------------------------|
|1            |                                     Subject|
|2            |                                    Activity|
|3            |              Time Body Acceleration Mean- X|
|4            |              Time Body Acceleration Mean- Y|
|5             |             Time Body Acceleration Mean- Z|
|6              |          Time Body Acceleration StdDev- X|
|7               |         Time Body Acceleration StdDev- Y|
|8             |           Time Body Acceleration StdDev- Z|
|9             |          Time Gravity Acceleration Mean- X|
|10            |          Time Gravity Acceleration Mean- Y|
|11            |          Time Gravity Acceleration Mean- Z|
|12            |        Time Gravity Acceleration StdDev- X|
|13            |        Time Gravity Acceleration StdDev- Y|
|14            |        Time Gravity Acceleration StdDev- Z|
|15            |        Time Body Acceleration Jerk-Mean- X|
|16            |        Time Body Acceleration Jerk-Mean- Y|
|17            |        Time Body Acceleration Jerk-Mean- Z|
|18            |      Time Body Acceleration Jerk-StdDev- X|
|19            |      Time Body Acceleration Jerk-StdDev- Y|
|20            |      Time Body Acceleration Jerk-StdDev- Z|
|21            |                Time Body Gyroscope Mean- X|
|22            |                Time Body Gyroscope Mean- Y|
|23            |                Time Body Gyroscope Mean- Z|
|24            |              Time Body Gyroscope StdDev- X|
|25            |              Time Body Gyroscope StdDev- Y|
|26            |              Time Body Gyroscope StdDev- Z|
|27            |           Time Body Gyroscope Jerk-Mean- X|
|28            |           Time Body Gyroscope Jerk-Mean- Y|
|29            |           Time Body Gyroscope Jerk-Mean- Z|
|30            |         Time Body Gyroscope Jerk-StdDev- X|
|31            |         Time Body Gyroscope Jerk-StdDev- Y|
|32            |         Time Body Gyroscope Jerk-StdDev- Z|
|33            |      Time Body Acceleration Magnitude Mean|
|34            |    Time Body Acceleration Magnitude StdDev|
|35            |   Time Gravity Acceleration Magnitude Mean|
|36            | Time Gravity Acceleration Magnitude StdDev|
|37            | Time Body Acceleration Jerk Magnitude Mean|
|38          | Time Body Acceleration Jerk Magnitude StdDev|
|39           |          Time Body Gyroscope Magnitude Mean|
|40           |        Time Body Gyroscope Magnitude StdDev|
|41           |     Time Body Gyroscope Jerk Magnitude Mean|
|42           |   Time Body Gyroscope Jerk Magnitude StdDev|
|43           |         Frequency Body Acceleration Mean- X|
|44           |         Frequency Body Acceleration Mean- Y|
|45           |         Frequency Body Acceleration Mean- Z|
|46           |       Frequency Body Acceleration StdDev- X|
|47           |       Frequency Body Acceleration StdDev- Y|
|48           |       Frequency Body Acceleration StdDev- Z|
|49           |    Frequency Body Acceleration Jerk-Mean- X|
|50           |    Frequency Body Acceleration Jerk-Mean- Y|
|51           |    Frequency Body Acceleration Jerk-Mean- Z|
|52           |  Frequency Body Acceleration Jerk-StdDev- X|
|53           |  Frequency Body Acceleration Jerk-StdDev- Y|
|54           |  Frequency Body Acceleration Jerk-StdDev- Z|
|55           |            Frequency Body Gyroscope Mean- X|
|56           |            Frequency Body Gyroscope Mean- Y|
|57           |            Frequency Body Gyroscope Mean- Z|
|58           |          Frequency Body Gyroscope StdDev- X|
|59           |          Frequency Body Gyroscope StdDev- Y|
|60           |          Frequency Body Gyroscope StdDev- Z|
|61           |  Frequency Body Acceleration Magnitude Mean|
|62           |Frequency Body Acceleration Magnitude StdDev|
|63   |Frequency Body Body Acceleration Jerk Magnitude Mean|
|64 |Frequency Body Body Acceleration Jerk Magnitude StdDev|
|65 |          Frequency Body Body Gyroscope Magnitude Mean|
|66  |       Frequency Body Body Gyroscope Magnitude StdDev|
|67   |   Frequency Body Body Gyroscope Jerk Magnitude Mean|
|68    |Frequency Body Body Gyroscope Jerk Magnitude StdDev|


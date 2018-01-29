# gettingandcleaningdata
Peer Graded Assignment Getting and Cleaning Data Coursera Project

## README FILE ADAPTED FROM:
Human Activity Recognition Using Smartphones Dataset, Version 1.0

Original Source:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

## Experimental Details Provided by Original Study Team:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

## OBJECTIVE:
The goal was to create a tidy dataset grouped by subject and activity summarizing the average of each of mean and standard deviation variable.

## PREREQUISITES:
The R program run_analysis.R uses R packages data.table, plyr, and stringr
The program will check to see if you have these packages installed-- if you do it will load them, if not it will install them for you.
You do not need to install them ahead of time.

Prior to initiating the r script download the datasets from the following location:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Move the datasets in the list below to your working directory.

## DATA FILES NEEDED IN WORKING DIRECTORY:
- 'features_info.txt'     Information about the variables used 
- 'features.txt'          A 561-feature vector with time and frequency domain variables.  561 variables in X datasets).
- 'activity_labels.txt'   Links the class labels with their activity name.
- 'train/X_train.txt'     Training set.(Accelerometer and Gyroscope Data with 561 Variables)
- 'test/X_test.txt'       Test set.  (Accelerometer and Gyroscope Data with 561 Variables)
- 'train/y_train.txt'     Training row labels.
- 'test/y_test.txt'       Test row labels.
- 'subject_train.txt'     Subject identifiers in training dataset
- 'subject_test.txt'      Subject identifiers in test dataset

## CODING & RUN INFORMATION
For more information on coding methodology see the codebook.
Running the code run_analysis.R will result in output of a tidy dataset to your working directory.
The name of the file will be "Average Sensor Signals By Subject and Activity.txt"  (a tab delimited text file)
A message is printed to indicate that the dataset has been created and exported to working directory.

## GITHUB REPOSITORY CONTAINS THE FOLLOWING FILES
README.MD
Codebook.txt
run_analysis.R
Average Sensor Signals by Subject and Activity.txt (tidy dataset)


## MORE INFORMATION
For more information about this dataset contact: activityrecognition@smartlab.ws

## LICENSE
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

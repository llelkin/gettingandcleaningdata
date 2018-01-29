# gettingandcleaningdata
Peer Graded Assignment Getting and Cleaning Data Coursera Project


README FILE ADAPTED FROM:
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

EXPERIMENTAL DETAILS PROVIDED BY ORIGINAL STUDY TEAM:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 



Datasets Accessed and Used for Final Tidy Dataset:

The original datasets provided from this study were:
- 'features_info.txt': Information about the variables used 
- 'features.txt': A 561-feature vector with time and frequency domain
                  variables.  561 variables in X datasets).
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'test/X_test.txt': Test set.
- 'train/y_train.txt': Training labels.
- 'test/y_test.txt': Test labels.
- 'subject_train.txt':  Subject identifiers in training dataset
- 'subject_test.txt': Subject identifiers in test dataset
 





Methodology for Creating Tidy Dataset: 

The goal was to create a tidy dataset grouped by subject and activity summarizing the average of each of mean and standard deviation variable.

Datasets listed above were loaded into R.
Columns in the X datasets were renamed using the features provided in features.text
The activity codes in the Y datasets were decoded by merging the activity labels in activity_labels_txt with the Y datasets.
Annotated datasets for training and test data were created using cbind to join subject information, activity labels, and results (training or test data).  
Training and Test datasets were stacked using Rbind—after creating a column source that identifies the source of each observation in the dataset as being from “training” or “test”.

Finally, the data was subset to include only the columns (variables) that provide information on mean or standard deviation of results.

Column names were modified to provide descriptive human-readable information as to the meaning of each variable.

The tidy dataset was output as a .csv file :
"Average Sensor Signals By Subject and Activity.csv"

A message is printed to indicate to user that dataset has been created and exported to working directory.




The dataset includes the following files:
=========================================

- 'README.txt'
- ‘Codebook.md’
- ‘run_analysis.R’ -  code provided to create tidy dataset
- ‘Average Sensor Singals by Subject and Activity.csv’ – tidy dataset




Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

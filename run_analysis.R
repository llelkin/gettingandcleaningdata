# Check for installed package and install missing package and/or load the libraries that you need
suppressMessages(install.load::install_load("data.table","plyr","stringr"))

#Load in the data sets
features <- read.table("features.txt",header=FALSE, sep=" ",col.names=c("FeatureCode","Feature"), as.is=TRUE) 
activity <- read.table("activity_labels.txt",header=FALSE,sep=" ",col.names=c("ActivityCode","Activity"),as.is=TRUE) 
xtrain <- read.table("X_train.txt",header = FALSE, fill = TRUE)
xtest <- read.table("X_test.txt",header = FALSE, fill = TRUE)
ytest <- read.table("Y_test.txt",header = FALSE, sep = " ", col.names = c("ActivityCode"),fill = TRUE)
ytrain <- read.table("Y_train.txt",header = FALSE, sep = " ", col.names = c("ActivityCode"), fill = TRUE)
strain <- read.table("subject_train.txt",header = FALSE, sep = " ", col.names = c("Subject"), fill = TRUE)
stest <- read.table("subject_test.txt",header = FALSE, sep = " ", col.names = c("Subject"), fill = TRUE)

# Rename column names in xtrain and xtest by Features in Features Dataset
h <- as.list(features$Feature)
colnames(xtest) <- c(h)
colnames(xtrain) <- c(h)

# Merge the dataset Activity into ytrain and ytest so that Activity Code has human-readable descriptor
ytrain <- merge(ytrain,activity,by.x = "ActivityCode",by.y = "ActivityCode",all.x = TRUE)
ytest <- merge(ytest,activity,by.x = "ActivityCode",by.y = "ActivityCode",all.x = TRUE)

# Bind columns from stest,ytest,xtest to make one dataset.  Do the same for the training datasets.
syxtest <- cbind(stest,ytest,xtest)
syxtrain <- cbind(strain,ytrain,xtrain)

# Before stacking the two datasets (train and test)...
# Create a variable that will identify each data source as coming from test or train (useful once they are merged)
syxtest$Source = "test"
syxtrain$Source = "train"
stack <- rbind(syxtrain, syxtest)


# Create a list of columns to keep (only mean and std)
# Create a dataset from features list of those features to keep
# Then create a variable that takes into account that column numbers in merged dataset shift by 3
# Then add the variables from the columns we merged in-- indicate column names, column number (FeatureCode is null)
# Then create a vector of column numbers to keep from the "Column" variable
# Finally, subset the stack dataset to include only the columns in our list (keep)

f <- features[!(features$Feature %like% "-meanFreq()") & 
                features$Feature %like% "-mean()" | features$Feature %like% "-std()" ,]
f$Column = f$FeatureCode + 3
add <- data.frame(FeatureCode=c(0,0,0,0), Feature=c("Subject","ActivityCode","Activity","Source"),Column=c(1,2,3,565))
f <- rbind(add,f)
keep <- as.vector(f$Column)
final <- stack[,keep]

# Rename the columns of the final dataset to be human-readable:
names(final) <- gsub("(?!^)(?=[[:upper:]])", " ", f$Feature, perl=TRUE)
a <- c("t ","f ","Acc ","Acc-", "Mag ", "Mag-", "Gyro ", "Gyro-", "mean", "std", "\\(|\\)")
b <- c("Time ","Frequency ","Acceleration ","Acceleration ", "Magnitude ", "Magnitude ", "Gyroscope ", "Gyroscope ","Mean", "StdDev","")
names(b) <- a
names(final) <- str_replace_all(names(final),b)

# Group final by Subject then by Activity to create the tidy dataset which averages all variables by subject & activity.
groupColumns = c("Subject","Activity")
dataColumns = c(1,5:70)
tidydata <- ddply(final, groupColumns, function(x) colMeans(x[dataColumns]))

#Reorder and Sort Columns of tidydata by Subject, Activity
tidydata <- tidydata[,c(2,1,3:68)]
tidydata <- tidydata[order(tidydata$Subject,tidydata$Activity),]

#Output the tidy dataset to working directory
write.table(tidydata,file="AverageSensorSignalsBySubjectandActivity.txt", sep = "\t", row.names=FALSE)

#Print message
print("Tidy Dataset 'Average Sensor Singals by Subject and Activity.txt' Has Been Exported to Your Working Directory")

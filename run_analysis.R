# Getting and Cleaning Data
# Coursera
# John Hopkins University

# Course Project
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, 
#create a second, independent tidy data set with the average of each variable for each activity and each subject.

##################################################################
#Pre-processing
#Load the plyr library
require(plyr)

# Directories and files
UCI_Dir <- "UCI HAR Dataset"
feature_file <- paste(UCI_Dir, "/features.txt", sep = "")
activity_labels_file <- paste(UCI_Dir, "/activity_labels.txt", sep = "")
x_train_file <- paste(UCI_Dir, "/train/X_train.txt", sep = "")
y_train_file <- paste(UCI_Dir, "/train/y_train.txt", sep = "")
subject_train_file <- paste(UCI_Dir, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(UCI_Dir, "/test/X_test.txt", sep = "")
y_test_file  <- paste(UCI_Dir, "/test/y_test.txt", sep = "")
subject_test_file <- paste(UCI_Dir, "/test/subject_test.txt", sep = "")

# Load raw data
features <- read.table(feature_file, colClasses = c("character"))
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

##################################################################
# 1. Merge the training and the test sets to create one data set.
##################################################################

# Use cbind and rbind to merge data
training_data <- cbind(cbind(x_train, subject_train), y_train)
test_data <- cbind(cbind(x_test, subject_test), y_test)
combined_data <- rbind(training_data, test_data)

# Label columns
col_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(combined_data) <- col_labels

############################################################################################
# 2. Extract the measurements on the mean and standard deviation for each measurement.
############################################################################################

data_extract_mean_stdDev <- combined_data[,grepl("mean|std|Subject|ActivityId", names(combined_data))]

###########################################################################
# 3. Uses descriptive activity names to name the activities in the data set
###########################################################################

data_extract_mean_stdDev <- join(data_extract_mean_stdDev, activity_labels, by = "ActivityId", match = "first")
data_extract_mean_stdDev <- data_extract_mean_stdDev[,-1]

##############################################################
# 4. Appropriately labels the data set with descriptive names.
##############################################################

# Remove parentheses
names(data_extract_mean_stdDev) <- gsub('\\(|\\)',"",names(data_extract_mean_stdDev), perl = TRUE)
# Make syntactically valid names
names(data_extract_mean_stdDev) <- make.names(names(data_extract_mean_stdDev))
# Make clearer names
names(data_extract_mean_stdDev) <- gsub('Acc',"Acceleration",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('GyroJerk',"AngularAcceleration",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('Gyro',"AngularSpeed",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('Mag',"Magnitude",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('^t',"TimeDomain.",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('^f',"FrequencyDomain.",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('\\.mean',".Mean",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('\\.std',".StandardDeviation",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('Freq\\.',"Frequency.",names(data_extract_mean_stdDev))
names(data_extract_mean_stdDev) <- gsub('Freq$',"Frequency",names(data_extract_mean_stdDev))

######################################################################################################################
# 5. Creates a second, independent tidy data set of sensor data with the average of each variable for each activity and each subject.
######################################################################################################################

sensor_avg_by_activity = ddply(data_extract_mean_stdDev, c("Subject","Activity"), numcolwise(mean))
write.table(sensor_avg_by_activity, file = "sensor_avg_by_activity.txt")


##Assignment:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
- 1.Merges the training and the test sets to create one data set.
- 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3.Uses descriptive activity names to name the activities in the data set
- 4.Appropriately labels the data set with descriptive variable names. 
- 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Files
- Data files in directory: UCI HAR Dataset -directory
- README.md, this file
- run_analysis.R , R-program producing requested output
- CodeBook.md , description of data and transformations done
- sensor_avg_by_activity.txt , aggregated tidy data from step 5


#Running the program
Download the dataset and extract into a folder in your working directory named "UCI HAR Dataset"
Download run_analysis.R and load into R Studio

#What the script does
The script is commented throughout, but here is a summary:

In the first step run_analysis.R uses cbind and rbind to merge the training and test data sets and label the colum names based on the features file. 

The second step extracts the values on the mean and standard deviation for each measurement.

The third step loads activity data and activity label data. Test and training activity data is merged into own dataset. Join is used to combine activity dataset with labels. This activity data is then merged as new columns into main dataset. 

The fourth step labels the data set with descriptive names.

The fifth step is creating the tidy dataset. 


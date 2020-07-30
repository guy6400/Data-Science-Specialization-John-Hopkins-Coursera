
### the steps towards tidy data according to this assignment are:

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#libraries

library(data.table)


## set directory:

setwd("G:\\Scripting\\R\\John Hopkins Data Science\\Getting and Cleaning Data")
path<- getwd()

##download assignment files:

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url, file.path(path, "dataFiles.zip"))

unzip(zipfile = "dataFiles.zip")


##load files containing labels for activities 

act_labels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"))
colnames(act_labels)<- c("act_index","act_name") # change col names
names(act_labels) #check


##load files containing labels for features

features <- fread(file.path(path, "UCI HAR Dataset/features.txt"))
colnames(features)<- c("feat_index","feat_name")# change col names
names(features) #check

relevant_feat <- grep("(mean|std)\\(\\)", features[, feat_name]) # retain only mean and sd var names
measure <- features[relevant_feat, feat_name] # new var containing only relevant
measure <- gsub('[()]', '', measurements) # remove unnecessary strings


## load train data:
#x_train
x_train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))
x_train<-x_train[,relevant_feat, with = FALSE] # maintains only relevant cols
colnames(x_train)<- measure # label the cols
#y_train
y_train <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"))
names(y_train) <- "Activity"
#subject_train
subject_train <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"))
names(subject_train) <- "num_subject"
#merge
train <- cbind(subject_train, y_train, x_train)


## load test data:
x_test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))
x_test<-x_test[,relevant_feat, with = FALSE] # maintains only relevant cols
colnames(x_test)<- measure # label the cols
#y_test
y_test <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"))
names(y_test) <- "Activity"
#subject_test
subject_test <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"))
names(subject_test) <- "num_subject"
#merge
test <- cbind(subject_test, y_test, x_test)

# merge datasets

df <- rbind(train, test)

## change activity indication to name:

df[["Activity"]] <- factor(df[, Activity]
                                 , levels = act_labels[["act_index"]]
                                 , labels = act_labels[["act_name"]])



### create a new dataset, with mean for each activity and subject:


df_melt <- melt(data = df, id = c("num_subject","Activity"))

df_casted <- dcast(data = df_melt,num_subject+Activity ~ variable,
                   fun.aggregate = mean)


write.csv(df_casted, file = "tidyData.csv")



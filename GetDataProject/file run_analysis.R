library("data.table")

path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)

# Activty
activityTest  <- read.table(file.path(path, "test" , "y_test.txt" ),header = FALSE)
activityTrain <- read.table(file.path(path, "train", "y_train.txt"),header = FALSE)

# Subject
subjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
subjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

# Feature
featuresTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

# 1. Merge Training and Test sets to one set

#Variable wise merging of data
subject <- rbind(subjectTrain, subjectTest)
activity<- rbind(activityTrain, activityTest)
features<- rbind(featuresTrain, featuresTest)

#Since the data is read from a txt, the columns do not have a name assigned to it.(HEADER=FALSE when read.table)
#Remedy that
names(subject)<-c("subject")
names(activity)<- c("activity")
featuresNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(features)<- featuresNames$V2

#Final MERGE
dat <- cbind(subject, activity)
data <- cbind(features, dat)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

#Features by measurements on the mean and standard deviation
sub<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]
sub

#Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(sub), "subject", "activity" )
selectedNames
data<-subset(data,select=selectedNames)

# 3. Uses descriptive activity names to name the activities in the data set

#activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)
#summary(activityLabels$V2)
data$activity[data$activity == 1] <- "Walking"
data$activity[data$activity == 2] <- "Walking Upstairs"
data$activity[data$activity == 3] <- "Walking Downstairs"
data$activity[data$activity == 4] <- "Sitting"
data$activity[data$activity == 5] <- "Standing"
data$activity[data$activity == 6] <- "Laying"

# 4. Appropriately labels the data set with descriptive variable names

#Names of Activity and Subject based Feature Names have been given descriptive Name
#Now to provide descriptive names to the Feature Names
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))

names(data)

# 5. Creates a second,independent tidy data set and ouput it

library(plyr);
DATA<-aggregate(. ~subject + activity, data, mean)
DATA<-DATA[order(DATA$subject,DATA$activity),]
write.table(DATA, file = "tidydata.txt",row.name=FALSE)


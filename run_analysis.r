# This script assumes that you have downloaded and unzipped all data from this repo.

# Read the variable labels from the original data set.
labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Make the variable names more easily-readable
labels$V2 <- tolower(labels$V2)
labels$V2 <- gsub("_","",labels$V2)

# Read the activities from features.txt
features <- read.table("UCI HAR Dataset/features.txt")

# Get the data from the training set
train.x.values <- read.table("UCI HAR Dataset/train/X_train.txt")
train.y.values <- read.table("UCI HAR Dataset/train/y_train.txt")
test.subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")


# Get the data from the test set
test.x.values <- read.table("UCI HAR Dataset/test/X_test.txt")
test.y.values <- read.table("UCI HAR Dataset/test/y_test.txt")
train.subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Need to coerce Y values into a numtreric vector for replacing them with activity labels later
test.y.values <- as.factor(as.numeric(test.y.values$V1))
train.y.values <- as.factor(as.numeric(train.y.values$V1))

# Get the proper variable names for the X values (from the features.txt dataset)
names(train.x.values) <- features$V2
names(test.x.values) <- features$V2

# Replace the activity label number codes with the actual activity label values
levels(test.y.values) <- labels$V2
levels(train.y.values) <- labels$V2

# Combine subjects, activities, and sensor readings.
test.values <- data.frame(test.subjects,test.y.values,test.x.values)
train.values <- data.frame(train.subjects,train.y.values,train.x.values)


names(test.values)[1] <- "subject"
names(train.values)[1] <- "subject"

names(test.values)[2] <- "activity"
names(train.values)[2] <- "activity"

# Merge the two data sets
merged.data <- rbind(test.values,train.values)


# Extract important features (defined as standard deviation and mean measurements)
important.features <- grep('mean[^F]|std',names(merged.data))
extracted.features <- merged.data[,important.features]
extracted.features <- data.frame(merged.data$subject,merged.data$activity,extracted.features)

names(extracted.features) <- tolower(names(extracted.features))
names(extracted.features) <- gsub("[[:punct:]]", "", names(extracted.features))

names(extracted.features)[1] <- "subject"
names(extracted.features)[2] <- "activity"

# Aggregate averages by subjects and activity to output later
averages <- aggregate(. ~ subject+activity,data=extracted.features,mean)

# Store the data sets
tidy.data <- write.csv(extracted.features,"tidydata.txt")
averages <- write.csv(averages,"average_means_and_standard_devs.txt")

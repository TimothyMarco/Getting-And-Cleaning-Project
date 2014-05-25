labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# Make the variable names more easily-readable
labels$V2 <- tolower(labels$V2)
labels$V2 <- gsub("_","",labels$V2)


features <- read.table("UCI HAR Dataset/features.txt")

train.x.values <- read.table("UCI HAR Dataset/train/X_train.txt")
train.y.values <- read.table("UCI HAR Dataset/train/y_train.txt")
test.subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

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


test.values <- data.frame(test.subjects,test.y.values,test.x.values)
train.values <- data.frame(train.subjects,train.y.values,train.x.values)


names(test.values)[1] <- "subject"
names(train.values)[1] <- "subject"

names(test.values)[2] <- "activity"
names(train.values)[2] <- "activity"

merged.data <- rbind(test.values,train.values)


important.features <- grep('mean[^F]|std',names(merged.data))
extracted.features <- merged.data[,important.features]
extracted.features <- data.frame(merged.data$subject,merged.data$activity,extracted.features)

names(extracted.features) <- tolower(names(extracted.features))
names(extracted.features) <- gsub("[[:punct:]]", "", names(extracted.features))

names(extracted.features)[1] <- "subject"
names(extracted.features)[2] <- "activity"

averages <- aggregate(. ~ subject+activity,data=extracted.features,mean)

tidy.data <- write.csv(extracted.features,"tidydata.txt")
averages <- write.csv(averages,"average_means_and_standard_devs.txt")

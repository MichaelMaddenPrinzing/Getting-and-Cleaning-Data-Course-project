# Find the names of the "features" that we want (i.e., the means and standard deviations)
features <- read.table("UCI HAR Dataset/features.txt")
wanted <- grep(".*mean.*|.*std.*", features[,2])
featureNames <- features[wanted,2]
featureNames <- gsub('-mean', 'Mean', featureNames)
featureNames <- gsub('-std', 'Std', featureNames)
featureNames <- gsub('[-()]', '', featureNames)


# Read in the training data
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")[wanted]

train <- cbind(trainSubjects, trainActivities, train)

# Read in the test data
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")[wanted]
test <- cbind(testSubjects, testActivities, test)

# Merge into a single dataframe
d <- rbind(train, test)
names(d) <- c("subject", "activity", featureNames)
d$activity <- ifelse(d$activity == 1, "walk", 
              ifelse(d$activity == 2, "walkUp",
              ifelse(d$activity == 3, "walkDown",
              ifelse(d$activity == 4, "sit",
              ifelse(d$activity == 5, "stand",
              ifelse(d$activity == 6, "lay", NA))))))
d$activity <- as.factor(d$activity)
d$subject <- as.factor(d$subject)

library(reshape2)
dMelt <- melt(d, id = c("subject", "activity"))
dMean <- dcast(dMelt, subject + activity ~ variable, mean)

write.table(dMean, "tidy.txt", row.names = F, quote = F)

## CREATE A TIDY DATA TABLE FROM THE TEST AND TRAIN DATA THAT GIVES THE MEAN FOR EACH MEASUREMENT (FEATURE)
## BASED ON SUBJECT-ACTIVITY GROUPINGS 



## LOAD TEST DATA
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

## LOAD TRAINING DATA
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

## LOAD FEATURE AND ACTIVITY DATA (THAT INCLUDES LABELS AND IDs)
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")



## STEP 1: MERGE TRAINING AND TEST DATA
## merge subject IDs (found in subject_test) and activity IDs (found in y_test$V1) to X_test
test_dat <- cbind(subject = subject_test$V1, 
                  activity = y_test$V1, 
                  X_test)
## merge subject IDs (found in subject_train) and activity IDs (found in y_train$V1) to X_train
train_dat <- cbind(subject = subject_train$V1, 
                   activity = y_train$V1, 
                   X_train)
## merge test and train data into one data set
all_data <- rbind(test_dat, train_dat)


## STEP 2: EXTRACT ONLY MEASUREMENTS ON MEAN AND STANDARD DEVIATION
## replace variable names of all_data with the specific feature names (found in features$V2)
features <- as.character(features$V2)
names(all_data) <- c("subject", "activity", features)
## subset only the measurements on the mean and standard deviation ("mean()" and "std()")
mean_sd_data <- all_data[, c(1, 2, which(grepl("std\\(\\)|mean\\(\\)", names(all_data))))]


## STEP 3: USE DESCRIPTIVE ACTIVITY NAMES IN THE DATA SET
## make activity_labels more readable: replace "_" with "" and make all lower case
activity_labels$V2 <- tolower(gsub("_", "", activity_labels$V2))
## merge specific activity names to combined data set (merge mean_sd_data with activity_labels based 
## on the activity id (1-6) found in activity_labels$V1)
library(dplyr)
mean_sd_data <- inner_join(mean_sd_data, activity_labels, by = c("activity" = "V1")) %>% 
                mutate(activity = V2) %>% 
                select(-V2)

## STEP 4: LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
## in this case, the variables have already been named with the correct feature names (see first part 
## of STEP 2 above) but using gsub to get rid of the parentheses will make them easier to work with
names(mean_sd_data) <- tolower(gsub("\\(\\)", "", names(mean_sd_data)))


## STEP 5: CREATES SEPARATE DATA SET (independent from mean_sd_data) THAT HAS THE AVERAGE OF EACH VARIABLE FOR
## EACH ACTIVITY AND EACH SUBJECT
## use the aggregate function to group mean_sd_data by subject and activity, and then apply the mean function 
## to variables 3 through 68 (all the measurements) based on each grouping
tidydata <- aggregate(mean_sd_data[, 3:68], 
                      by = mean_sd_data[c("subject", "activity")], 
                      FUN = mean)
tidydata <- arrange(tidydata, subject, activity)
## write the tidy data table to a text file
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)
## tidydata has 180 rows and 68 columns


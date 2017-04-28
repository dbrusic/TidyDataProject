# Getting and Cleaning Data Course Project

This readme file explains how `run_analysis.R` works (from downloading the data to creating the final tidy data set), how to use `run_analysis.R`, and how it directly follows the instructions for the Getting and Cleaning Data Coursera course project. 

#### Instructions for using `run_analysis.R`:
**Step 1: Download Data**

* The following code will download the correct data and unzip it into a directory called `projectdata` (if you have not already downloaded the data and unzipped it yourself):

```
if(!file.exists("./projectdata")) {dir.create("./projectdata")}
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = temp)
unzip(temp, exdir = "./projectdata")
unlink(temp)
setwd("~./projectdata")
```
* The last line of code from above sets your working directory to `projectdata`. 
* Save the `run_analysis.R` script to the `projectdata` directory because it will be reading multiple files that are within that directory. *Again, in order for `run_analysis.R` to work, your working directory must be set to `projectdata` or whatever directory you have `UCI HAR Dataset` saved to. Otherwise, you will have to specify the file path for each `read.table` function in `run_analysis.R`.*


**Step 2: Source `run_analysis.R` Script**

* The `run_analysis.R` script requires the user to have the `dplyr` package installed in R. `install.packages("dplyr")` will install it. For more information on the `dplyr` package see this [link].
* Now run the script: `source("run_analysis.R")`

How `run_analysis.R` works:

* The script begins by reading the necessary files into R using the `read.table` function. *See the `CodeBook.md` text file that accompanies this `readme` for more information on the six files that are read, and how they all fit together.*
* Then the training and test data are merged into one large data table called `all_data`. The variables of this table are subject IDs, activity IDs, and all 561 of the feature measurements (each unnamed at this point).  
* All the variables in `all_data` are then given names (subject, activity, and the 561 feature names found in `features`). This is done by converting the feature names into character strings and then using the `names` function to assign the specific names to each of the 3:563 columns of `all_data`.
* The `grepl` function is used to find and subset the desired feature variables that contain "mean()" and "std()". The project assignment requires `run_analysis.R` to extract only the measurements on the mean and standard deviation for each measurement. Some variable names have the word "Mean" in their name but were not included in this subset because they were not part of the original base signal measurements. *See `features_info.txt` in the `UCI HAR Dataset` folder for more information.*
* `mean_sd_data` is the data table that contains the subsetted variables (subject, activity, and 66 features that contain "mean()" and "std()")
* The activity names found in `activity_labels` are made all lower case and the underscore in names consisting of two words is replaced. So, "WALKING_UPSTAIRS" becomes "walkingupstairs". This was done to make the labels more compact and easier to type when working with the data in the future.
* The activity names (laying, sitting, walking, etc.) are added to `mean_sd_data` by merging `activity_labels` to it based on the activity ID numbers (1-6). The `inner_join` function from the `dplyr` package does this, and then `mutate` and `select` complete the process of replacing the activity IDs in `mean_sd_data` with the descriptive activity names. 
* The `gsub` function is used to remove all sets of parentheses in all the variable names of `mean_sd_data`. The variable names are also converted to lower case. Again, this was done to make the variables more compact and easier to type in the future (don't have to worry about single upper case letters and always typing parenthese). The variable names for all the features were kept in their abbreviated form to keep them compact (saving space and easier to type). *See `features.txt` and `features_info.txt` in the `UCI HAR Dataset` folder for more details on the exact names of the feature variables.*
* The final step of `run_analysis.R` creates a new data table from `mean_sd_data` using the `aggregate` function:
	* This [website] explains how to summarize data using the `aggregate` function.
	* In this case, `aggregate` takes three arguments: 
		1. The values that will be summarized (variables 3:68 in `mean_sd_data`; the feature measurements).
		2. The variable/s to group the summarized values by (subject and activity).
		3. The function to apply to the specified values from the first argument (mean).
	* `aggregate` creates groups based on each subject performing each activity. This creates 180 groups.
	* It then finds the average value of each feature measurement for each of these groups.
	* This generates the final tidy data table that is 180 rows by 68 columns. Each subject-activity group now has an average value for each feature measurement. *Again, the feature measurements (columns 3:68) now represent average values.*
	* The `arrange` function then orders this data table based on the subject column first and then the activity column.  

*See the `run_analysis.R` script for in-line explanations of how it works.*

[link]: <https://cran.r-project.org/web/packages/dplyr/README.html>
[website]: <http://www.cookbook-r.com/Manipulating_data/Summarizing_data/#using-aggregate>


**Step 3: Reading `tidydata` into R**

* `run_analysis.R` writes `tidydata` to a text file called `tidydata.txt`. It is saved in the working directory that `run_analysis.R` is sourced in.
* Set your working directory to the directory in which `tidydata.txt` is saved and use `read.table("tidydata.txt", header = TRUE)` to read the table into R.

---
`tidydata` is tidy because each variable forms a column, each observation forms a row, and the table is made up of only one type of observational unit (smartphone signals measuring the subjects position in space while that subject is performing a certain activity).

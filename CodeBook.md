# Code Book
This code book describes the data, variables, and transformations that were used to create a data table with `run_analysis.R` for the Getting and Cleaning Data Coursera course project. The data comes from a study that tested a smartphone's ability to recognize human activity. A total of 30 subjects wore the phone and performed 6 different activities (see below) as the phone recorded different measurements of the subject's position in space. 21 of these subjects make up the train data and 9 make up the test data.

---
### Study Design
The data for this project was downloaded from this [url]. The data files that were used to produce the data table with `run_analysis.R` are found in the `UCI HAR Dataset` folder. The exact files downloaded and used to produce the data table are:

* `features.txt`: 561 by 2 table with all (561) feature names (names of the types of measurements made during the study) 
* `activity_labels.txt`: 6 by 2 table with id number (1-6; corresponding to an ID number in y_test and y_train) and activity name (walking, walking upstairs, walking downstairs, sitting, standing, and laying)
* `test/X_test.txt`: 2947 by 561 table comprised of all measurements for each of 561 features and each of 9 subjects who were used to generate the test data  
* `test/y_test.txt`: 2947 by 1 table comprised of activity ID numbers (1-6) representing the activity that a subject performed for the given window sample 
* `test/subject_test.txt`: 2947 by 1 table in which each row identifies the subject who performed the activity in each window sample
* `train/X_train.txt`: 7352 by 561 table comprised of all measurements for each of 561 features and each of 21 subjects who were used to generate the train data
* `train/y_train.txt`: 7352 by 1 table comprised of activity ID numbers (1-6) representing the activity that a subject performed for the given window sample
* `train/subject_train.txt`: 7352 by 1 table in which each row identifies the subject who performed the activity in each window sample

*See `features_info.txt` and `README.txt` in the `UCI HAR Dataset` folder for more information on where this data comes from and how it was downloaded.*

[url]: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>


---
### Transformations made on the data:
General transformations and combinations done to the data to create a tidy data set:

1. Merge the columns of `subject_test` (subject IDs) and `y_test` (activity IDs) to `X_test` (same for train data)
2. Merge the rows of the test data and train data created from step 1
3. Change the variable names (3:563) in the combined test-train data table to the feature names (561 of them) found in `features`
4. Convert the activity IDs to the actually activity names found in `activity_labels`
5. Make the variable names and activity labels easier to work with (lower case, removing excess writing)
6. Subset only feature measurements in which the feature name has either "mean()" or "std()"
7. Create groups based on each subject performing each activity (subject-activity groups)
8. Create final data table that summarizes each subject-activity group by its average of each subsetted feature 

The final data table is called `tidydata` 

*See `ReadMe.md` file for more information on how the `run_analysis.R` script works (and more specifically how each step of the Coursera project was completed through this script).*


---
### Variables 
####There are 68 total variables found in `tidydata` (the data table created with `run_analysis.R`)

1. subject: an integer (1-30) corresponding to the subject who performed the activity                     
2. activity: an activity (walking, walking upstairs, walking downstairs, sitting, standing, and laying) that the subject performed



 *Information on the rest of the variables can be found in the `features_info.txt` file in the `UCI HAR Dataset` folder. The features used to create the final tidy set for this project were only the 66 that were means and standard deviations of signals recorded by the smartphone. The average was then taken of each of these mean/std features based on each subject-activity grouping. Therefore, the following variables all represent averages in `tidydata`:*
                   
3. tbodyacc-mean-x            
4. tbodyacc-mean-y            
5. tbodyacc-mean-z            
6. tbodyacc-std-x             
7. tbodyacc-std-y             
8. tbodyacc-std-z             
9. tgravityacc-mean-x         
10. tgravityacc-mean-y         
11. tgravityacc-mean-z         
12. tgravityacc-std-x          
13. tgravityacc-std-y          
14. tgravityacc-std-z          
15. tbodyaccjerk-mean-x        
16. tbodyaccjerk-mean-y        
17. tbodyaccjerk-mean-z        
18. tbodyaccjerk-std-x         
19. tbodyaccjerk-std-y         
20. tbodyaccjerk-std-z         
21. tbodygyro-mean-x           
22. tbodygyro-mean-y           
23. tbodygyro-mean-z           
24. tbodygyro-std-x            
25. tbodygyro-std-y            
26. tbodygyro-std-z            
27. tbodygyrojerk-mean-x       
28. tbodygyrojerk-mean-y       
29. tbodygyrojerk-mean-z       
30. tbodygyrojerk-std-x        
31. tbodygyrojerk-std-y        
32. tbodygyrojerk-std-z        
33. tbodyaccmag-mean           
34. tbodyaccmag-std            
35. tgravityaccmag-mean        
36. tgravityaccmag-std         
37. tbodyaccjerkmag-mean       
38. tbodyaccjerkmag-std        
39. tbodygyromag-mean          
40. tbodygyromag-std           
41. tbodygyrojerkmag-mean      
42. tbodygyrojerkmag-std       
43. fbodyacc-mean-x            
44. fbodyacc-mean-y            
45. fbodyacc-mean-z            
46. fbodyacc-std-x             
47. fbodyacc-std-y             
48. fbodyacc-std-z             
49. fbodyaccjerk-mean-x        
50. fbodyaccjerk-mean-y        
51. fbodyaccjerk-mean-z        
52. fbodyaccjerk-std-x         
53. fbodyaccjerk-std-y         
54. fbodyaccjerk-std-z         
55. fbodygyro-mean-x           
56. fbodygyro-mean-y           
57. fbodygyro-mean-z           
58. fbodygyro-std-x            
59. fbodygyro-std-y            
60. fbodygyro-std-z            
61. fbodyaccmag-mean           
62. fbodyaccmag-std            
63. fbodybodyaccjerkmag-mean   
64. fbodybodyaccjerkmag-std    
65. fbodybodygyromag-mean      
66. fbodybodygyromag-std       
67. fbodybodygyrojerkmag-mean  
68. fbodybodygyrojerkmag-std
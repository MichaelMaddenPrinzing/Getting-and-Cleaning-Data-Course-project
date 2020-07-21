tidy.txt is a tidy dataset, constructed from the raw data (downloaded off of the course website) using run_analysis.R

run_analysis.R first reads in features.txt and finds the rows for the "features" (not sure what those are) that mention a mean or standard deviation.
It then cleans up the names of these "features", to be used as column names later. The script then reads in the training and test data. The raw data had seperate
files for the subjects, activities, and observations. Each is read in, and then bound together as columns of dataframes. The test and train dataframs are then 
combined and the column names updated. The first column is a subject ID number. The second column is an activity (one of the 6 from this experiment). 
The following columns are the "features" mentioned above.

Finally, the scripts constructs a summary dataframe, by melting the original dataframe and then dcasting it to give the means for each variable (other than subject
and activity), grouped by subject and activity. This summary dataframe is written to the file tidy.txt.

# Getting and Cleaning Data Course Project
*Created by Tim Marco on May 25th, 2014 for the Coursera Getting and Cleaning Data Course. Contact: timothymarco@gmail.com*

This repo manipulates and cleans smartphone activity monitoring data collected by the University of California - Irvine, and presents them in a more usable fashion. The data in the initial set measure triaxial movements along a variety of measurements, and are broken down by subjects and activity types.


# Files / directories included in the repo

## run_analysis.r
The **run_analysis.r** script cleans the UCI Smartphone Data set and creates two outputs:
1. **tidydata.txt**: a cleaned data set that extracts the most important features from the original data and presents them in a more usable manner. (This is further explained below)
2. **average_means_and_standard_devs.txt**: a separate data set that calculates the mean value of each variable for each subject and activity pair.


### Details on data points extracted

The initial dataset included **561** different variables collected from the smartphone sensors. To pare down this list, I included only the measurements related to **standard deviations** and **means** for the factors. This was done using a simple **grep()** function, which matches variable names with either 'mean' or 'std'.


## codebook.md
A codebook that explains the variables output by *run_analysis.r*.

## UCI HAR Dataset / getdata-projectfiles-UCI HAR Dataset (1)
The original dataset (.zip file) and expanded out for use in run_analysis.r. These data were downloaded on May 19th, 2014 from <a href='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'>this URL</a>.
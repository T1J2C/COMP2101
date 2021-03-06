#!/bin/bash
#
# this script generates a report of the files on the system that have the setuid permission bit turned on
# it is for the lab1 exercise
# it uses the find command to find files of the right type and with the right permissions, and an error redirect to
# /dev/null so we do not get errors for inaccessible directories and files
# the identified files are sorted by their owner

# Task 1 for the exercise is to modify it to also display the 12 largest regular files in the system, sorted by their sizes
# The listing should
#    only have the file name, owner, and size of the 12 largest files
#    show the size in human friendly format
#    be displayed after the listing of setuid files
#   should have its own title, similar to how the setuid files listing has a title
# use the find command to generate the list of files with their sizes, with an error redirect to /dev/null
# use cut or awk to display only the output desired

echo "Setuid files:"
echo "============="
find / -type f -executable -perm -4000 -ls 2>/dev/null | sort -k 5

echo "12 Largest Files in System"
echo "=========================="

#NOTES
#using find command, passing in the -type as f to find regular files.
#previously was taking a long time, only finding files greater than 1M to get rid of irrelevant files
#using -exec {} + so I can ls my find results and have them display in long format (with all relevant info for task) all files, and human readable format
#sending all errors to /dev/null
#sorting in reverse so largest files are on top, and again in human readable format.
#using head to show only the top 12 results
#finally using awk to only show the 4th 5th and 9th column to only show owner file size and the file name

#EDIT: Changed the sort command to sort by the file size(key=column 5) Looks better now. 
find / -type f -size +1M -exec ls -lah {} + 2>/dev/null | sort -hr -k 5 | head -n 12 | awk '{print$4,$5,$9}'



# for the task, add
# commands to display a title
# commands to make a list of the 12 biggest files
# sort/format whatever to display the list properly

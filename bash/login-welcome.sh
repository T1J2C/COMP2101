#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
###############
myname="$USER"
hostname="$(hostname)"
timeAndDay="It is $(date +%A) at $(date +%l:%M) $(date +%p)"
day=$(date +%A)

###############
# Main        #
###############
if [ "$day"=="Monday" ]; then
 title="Hungry Hungry"
elif [ "$day"=="Tuesday" ]; then
 title="Grand Ol'"
elif [ "$day"=="Wednesday" ]; then
 title="Oh Wise"
elif [ "$day"=="Thursday" ]; then
 title="Big Bad"
elif [ "$day"=="Friday" ]; then
 title="Linux Wizard"
elif [ "$day"=="Saturday" ]; then
 title="Sir"
elif [ "$day"=="Sunday" ]; then
 title2=" ,The Graceful One"
fi

welcomeText= cat <<EOF

Welcome to planet $hostname, "$title $myname $title2!". "$timeAndDay"

EOF

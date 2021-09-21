#!/bin/bash
#
# this script rolls a pair of six-sided dice and displays both the rolls
#

# Task 1:
#  put the number of sides in a variable which is used as the range for the random number
#  put the bias, or minimum value for the generated number in another variable
#  roll the dice using the variables for the range and bias i.e. RANDOM % range + bias

# Task 2:
#  generate the sum of the dice
#  generate the average of the dice

#  display a summary of what was rolled, and what the results of your arithmetic were

# Tell the user we have started processing
echo "Rolling..."
# roll the dice and save the results

#Created sides and bias variables
sides=$((20))
bias=$((5))

#changed original values 6 + 1 to my new variables
die1=$(( RANDOM % sides + bias))
die2=$(( RANDOM % sides + bias ))

#Sometimes when testing, I noticed that the dice would roll over 20, I figured this is because of the + bias
#I created if statements to check if the roll was greater than 20, and if so, just make it equal to 20
#I could have just made the max sides 15... but this was more fun to figure out.
if [ "$die1" -gt 20 ]
then
 die1=$((20))
elif [ "$die2" -gt 20 ]
then
 die2=$((20))
fi
# display the results
echo "Rolled $die1, $die2"

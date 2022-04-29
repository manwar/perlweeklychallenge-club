#!/usr/bin/env python3

# Challenge 040
#
# TASK #1
# Show multiple arrays content
# You are given two or more arrays. Write a script to display values of each
# list at a given index.
#
# For example:
#
# Array 1: [ I L O V E Y O U ]
# Array 2: [ 2 4 0 3 2 0 1 9 ]
# Array 3: [ ! ? @ $ % ^ & * ]
# We expect the following output:
#
# I 2 !
# L 4 ?
# O 0 @
# V 3 $
# E 2 %
# Y 0 ^
# O 1 &
# U 9 *

def show_multiple(data):
    for j in range(0, len(data[0])):
        for i in range(0, len(data)):
            print(data[i][j], end=" ")
        print("")

show_multiple([['I', 'L', 'O', 'V', 'E', 'Y', 'O', 'U'],
               ['2', '4', '0', '3', '2', '0', '1', '9'],
               ['!', '?', '@', '$', '%', '^', '&', '*']])

#!/usr/bin/python3

# Challenge 032
#
# Task #1
# Contributed by Neil Bowers
# Count instances
# Create a script that either reads standard input or one or more files
# specified on the command-line. Count the number of times and then print a
# summary, sorted by the count of each entry.
# 
# So with the following input in file example.txt
# 
# apple
# banana
# apple
# cherry
# cherry
# apple
# the script would display something like:
# 
# apple     3
# cherry    2
# banana    1
# For extra credit, add a -csv option to your script, which would generate:
# 
# apple,3
# banana,1
# cherry,2

import fileinput
import sys

# command line options
sep = "\t"
if len(sys.argv)>1 and sys.argv[1]=="-csv":
    sys.argv.pop(1)
    sep = ","

# count instances
count = {}
for line in fileinput.input():
    word = line.strip()
    if word in count:
        count[word] += 1
    else:
        count[word] = 1

# output
for key in sorted(count):
    print(f"{key}{sep}{count[key]}")

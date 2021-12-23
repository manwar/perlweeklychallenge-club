#!/usr/bin/python3

# Challenge 031
#
# Task #2
# Create a script to demonstrate creating dynamic variable name, assign a value
# to the variable and finally print the variable. The variable name would be
# passed as command line argument.

import sys

globals()[sys.argv[1]] = 10
print(globals()[sys.argv[1]])

#!/usr/bin/env python

# Challenge 001
#
# Challenge #1
# Write a script to replace the character ‘e’ with ‘E’ in the string
# ‘Perl Weekly Challenge’. Also print the number of times the character ‘e’
# is found in the string.

import sys

str = " ".join(sys.argv[1:])
print(str.count('e'), str.replace('e', 'E'))

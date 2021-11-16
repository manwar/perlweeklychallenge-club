#!/usr/bin/python3

# Challenge 010
#
# Challenge #2
# Write a script to find Jaro-Winkler distance between two strings. For more
# information check wikipedia page.

import sys
from pyjarowinkler import distance

print("{:.2f}".format(1-distance.get_jaro_distance(*sys.argv[1:3])))

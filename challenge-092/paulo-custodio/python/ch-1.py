#!/usr/bin/env python

# Challenge 092
#
# TASK #1 > Isomorphic Strings
# Submitted by: Mohammad S Anwar
# You are given two strings $A and $B.
#
# Write a script to check if the given strings are Isomorphic. Print 1 if they
# are otherwise 0.
#
# Example 1:
# Input: $A = "abc"; $B = "xyz"
# Output: 1
# Example 2:
# Input: $A = "abb"; $B = "xyy"
# Output: 1
# Example 3:
# Input: $A = "sum"; $B = "add"
# Output: 0

import sys

def isomorphic(a,b):
	if len(a)!=len(b):
		return 0
	else:
		mapping = {}
		mapped = {}
		for i in range(0, len(a)):
			if not a[i] in mapping:			# a is new
				if b[i] in mapped:			# b already mapped to some other a
					return 0
				else:						# store mapping
					mapping[a[i]] = b[i]
					mapped[b[i]] = 1
			else:							# a already occurred
				if mapping[a[i]]!=b[i]:		# previous mapping is different
					return 0
		return 1

print(isomorphic(sys.argv[1], sys.argv[2]))

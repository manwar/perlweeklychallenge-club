#!/usr/bin/env python

# Challenge 096
#
# TASK #2 > Edit Distance
# Submitted by: Mohammad S Anwar
# You are given two strings $S1 and $S2.
# 
# Write a script to find out the minimum operations required to convert $S1
# into $S2. The operations can be insert, remove or replace a character. Please
# check out Wikipedia page for more information.
# 
# Example 1:
# Input: $S1 = "kitten"; $S2 = "sitting"
# Output: 3
# 
# Operation 1: replace 'k' with 's'
# Operation 2: replace 'e' with 'i'
# Operation 3: insert 'g' at the end
# Example 2:
# Input: $S1 = "sunday"; $S2 = "monday"
# Output: 2
# 
# Operation 1: replace 's' with 'm'
# Operation 2: replace 'u' with 'o'

# NOTE: the  Wagner-Fischer Distance algorithm builds a table of distances 
#		from which the operations can be deduced

import sys

def wag_fis_dist(a, b):

	# define a table where d[i,j] is the Levenshtein distance between 
	# first i chars of a and first j chars of b
	d = [ [ 0 for j in range(0, len(b)+1) ] for i in range(0, len(a)+1) ]
	
	# source prefixes can be transformed into empty string by dropping chars
	for i in range(1, len(a)+1):
		d[i][0] = i	

	# target prefixes can be reached from empty source prefix by inserting chars
	for j in range(1, len(b)+1):
		d[0][j] = j 
	
	# flood-fill the rest of the table
	for j in range(1, len(b)+1):
		for i in range(1, len(a)+1):
			subst_cost = 0 if a[i-1] == b[j-1] else 1
			d[i][j] = min(d[i-1][j]+1,				# deletion	
						  d[i][j-1]+1,				# insertion
						  d[i-1][j-1]+subst_cost)	# substitution

	# distance is in lower bottom cell
	print(d[len(a)][len(b)])
	
	# traverse the minimum path
	i, j, step = 0, 0, 0
	while i < len(a) or j < len(b):
		min_dir, min_delta = '', 1e10
		
		# search shortest path in priority SE, E, S
		if i < len(a) and j < len(b):
			dir, delta = "SE", d[i+1][j+1] - d[i][j]
			if delta < min_delta:
				min_dir, min_delta = dir, delta
		
		if j < len(b):
			dir, delta = "E", d[i][j+1] - d[i][j]
			if delta < min_delta:
				min_dir, min_delta = dir, delta
			
		if i < len(a):
			dir, delta = "S", d[i+1][j] - d[i][j]
			if delta < min_delta:
				min_dir, min_delta = dir, delta
		
		# apply shortest path and show steps
		if min_dir == "SE":
			i, j = i+1, j+1
			frm, to = a[i-1], b[j-1]
			if frm != to:
				step += 1
				print(f"Operation {step}: replace '{frm}' with '{to}'")
		elif min_dir == "E":
			i, j = i, j+1
			add = b[j-1]
			step += 1
			at = "at end" if j == len(b) else f"at position {j}"
			print(f"Operation {step}: insert '{add}' {at}")
		elif min_dir == "S":
			i, j = i+1, j
			dl = a[i-1]
			step += 1
			at = "at end" if i == len(a) else f"at position {i}"
			print(f"Operation {step}: delete '{dl}' {at}")
		else:
			assert 0

a, b = tuple(sys.argv[1:3])
wag_fis_dist(a, b)

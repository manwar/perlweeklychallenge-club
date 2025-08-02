#!/usr/bin/env perl

# Challenge 282
#
# Task 2: Changing Keys
# Submitted by: Mohammad Sajid Anwar
#
# You are given an alphabetic string, $str, as typed by user.
#
# Write a script to find the number of times user had to change the key to type
# the given string. Changing key is defined as using a key different from the
# last used key. The shift and caps lock keys won't be counted.
#
# Example 1
#
# Input: $str = 'pPeERrLl'
# Ouput: 3
#
# p -> P : 0 key change
# P -> e : 1 key change
# e -> E : 0 key change
# E -> R : 1 key change
# R -> r : 0 key change
# r -> L : 1 key change
# L -> l : 0 key change
#
# Example 2
#
# Input: $str = 'rRr'
# Ouput: 0
#
# Example 3
#
# Input: $str = 'GoO'
# Ouput: 1

import re
import sys

str = sys.argv[1].upper()
str, count = re.subn(r'(.)\1*', r'\1', str)

print(len(str)-1)

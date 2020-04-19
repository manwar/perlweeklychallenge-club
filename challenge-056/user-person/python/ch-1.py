#!/usr/bin/env python3

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/         #
#                                                                         #
# Diff-K                                                                  #
# You are given an array @N of positive integers (sorted) and another     #
# non negative integer k.                                                 #
# Write a script to find if there exists 2 indices i and j such that      #
# A[i] - A[j] = k and i != j.                                             #
#                                                                         #
# It should print the pairs of indices, if any such pairs exist.          #
#                                                                         #
# Example:                                                                #
#                                                                         #
#         @N = (2, 7, 9)                                                  #
#         $k = 2                                                          #
#                                                                         #
# Output : 2,1                                                            #
#                                                                         #
###########################################################################

n = [2, 7, 9]
k = 2
match = []

i = len(n)-1

while i > 0:
    j = i-1
    diff = n[i] - k

    while n[j] >= diff:
        if n[j] == diff:
            match.append('({}, {})'.format(i,j))
        j -= 1
    i -= 1

if len(match):
    match.reverse()
    for x in match:
        print(x,end=" ")
    print()

# output:
#
# (2, 1) 

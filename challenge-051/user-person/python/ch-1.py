#!/usr/bin/env python3

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-051/         #
#                                                                         #
# 3 Sum                                                                   #
# Given an array @L of integers. Write a script to find all unique        #
# triplets such that a + b + c is same as the given target T. Also make   #
# sure a <= b <= c.                                                       #
#                                                                         #
# https://en.wikipedia.org/wiki/3SUM                                      #
#                                                                         #
# Example:                                                                #
#                                                                         #
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);                                   #
#                                                                         #
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.                     #
#                                                                         #
###########################################################################

import re
import sys

L = [-25, -10, -7, -3, 2, 4, 8, 10]
T = 0

if len(sys.argv) > 1:

    input = ' '.join(sys.argv[1:])
    input = re.sub(r'[][)(, ]+', ' ', input)
    input = re.sub(r'\A\s+|\s+\Z', '', input)
    L     = re.split(r' ', input)

    for num in L:
        num    = re.sub(r'\A0+\Z', '0', num)
        numPat = re.compile(r'\A0+(-?\d+)')
        num    = re.sub(numPat, r'\1', num)
                        
    L = list(map(int,L))
   
else:

    print('Using default input L:',L)

L.sort()
seen = {}
    
for         i in range(     len(L)-2):
    for     j in range(i+1, len(L)-1):
        for k in range(j+1, len(L)  ):

            sum = L[i] + L[j] + L[k]

            if sum == T:
                digString = '%i + %i + %i = %i' % ( L[i], L[j], L[k], T)
                if digString in seen:
                    continue
                else:
                    print(digString)
                    seen.update({digString : True})

# output:
#
# Using default input L: [-25, -10, -7, -3, 2, 4, 8, 10]
# -10 + 2 + 8 = 0
# -7 + -3 + 10 = 0
                
                

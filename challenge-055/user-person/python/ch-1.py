#!/usr/bin/env python3

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/         #
#                                                                         #
# Flip Binary                                                             #
#                                                                         #
# You are given a binary number B, consisting of N binary digits          #
# 0 or 1: s0,s1, ..., s(N-1).                                             #
#                                                                         #
# Choose two indices L and R such that 0 <= L <= R < N and flip the       #
# digits s(L),s(L+1), ... , s(R) By flipping, we mean changing 0 to 1     #
# and vice-versa.                                                         #
#                                                                         #
# Write a script to find the indices (L,R) that results in a              #
# binary number with maximum number of 1s. If you find more than one      #
# maximal pair L,R then print all of them.                                #
#                                                                         #
# Continuing our example, note that we had three pairs (L=0, R=0),        #
# (L=0, R=2), and (L=2, R=2) that resulted in a binary number with        #
# two 1s, which was the maximum. So we would print all three pairs.       #
#                                                                         #
###########################################################################

import re
import sys
    
originalString = "010"

if len(sys.argv) > 1:
    originalString = ''.join(sys.argv[1:])
    if re.search(r'[^01]', str(originalString)):
        sys.stderr.write('Arguments can only contain 1s and 0s.\n')
        sys.exit(1)
else:
    sys.stderr.write('No arguments given. Using example data: 010\n')

n = len(originalString)
lowerBound = 0
upperBound = n
max = 0
maxes = []

hasZeroes = False
if re.search(r'0', originalString):
    hasZeroes = True

if re.search(r'\A1+', originalString) and hasZeroes:
    front = re.search(r'\A(1+)', originalString)
    lowerBound = len(front.group(0))

if re.search(r'1+\Z', originalString) and hasZeroes:
    back = re.search(r'(1+)\Z', originalString)
    difference = len(back.group(0))
    upperBound = n - difference
    
left = lowerBound
while left <= upperBound:
    
    right = left+1

    while right <= upperBound:
        binarySet = list(originalString)
        for x in range(left,right,1):
            if binarySet[x] == '0':
                 binarySet[x] ='1'
            elif binarySet[x] == '1':
                binarySet[x] = '0'

        num = binarySet.count('1')
        
        if num > max:
            max = num
            maxes = []
            maxes.append('(L=%d, R=%d)' % (left, right-1))
        elif num == max:
            maxes.append('(L=%d, R=%d)' % (left, right-1))

        right += 1
    left += 1
    
for coord in maxes:
    print(coord,end=' ')
else:
    print()

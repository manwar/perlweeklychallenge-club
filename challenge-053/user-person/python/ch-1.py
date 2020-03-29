#!/usr/bin/env python3

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/         #
#                                                                         #
# Rotate Matrix                                                           #
# Write a script to rotate the followin matrix by given 90/180/270        #
# degrees clockwise.                                                      #
#                                                                         #
# [ 1, 2, 3 ]                                                             #
# [ 4, 5, 6 ]                                                             #
# [ 7, 8, 9 ]                                                             #
#                                                                         #
# For example, if you rotate by 90 degrees then expected result should    #
# be like below                                                           #
#                                                                         #
# [ 7, 4, 1 ]                                                             #
# [ 8, 5, 2 ]                                                             #
# [ 9, 6, 3 ]                                                             #
#                                                                         #
###########################################################################

from itertools import chain
import os
import re
import sys

matrix = [[1,2,3],
          [4,5,6],
          [7,8,9]];

#______________________________________
# 0 start  |   90   |   180  |   270  |
# 1 [0][0] | [0][2] | [2][2] | [2][0] |
# 2 [0][1] | [1][2] | [2][1] | [1][0] |
# 3 [0][2] | [2][2] | [2][0] | [0][0] |
# 4 [1][0] | [0][1] | [1][2] | [2][1] |
# 5 [1][1] | [1][1] | [1][1] | [1][1] |
# 6 [1][2] | [2][1] | [1][0] | [0][1] |
# 7 [2][0] | [0][0] | [0][2] | [2][2] |
# 8 [2][1] | [1][0] | [0][1] | [1][2] |
# 9 [2][2] | [2][0] | [0][0] | [0][2] |
#__________|________|________|________|

#     inner   outer
#   0 row 0 + col 0 +
#  90 col 2 - row 0 +
# 180 row 2 - col 2 -
# 270 col 2 - row 0 +

width = 0
rawNums = []

rawNums = list(chain.from_iterable(matrix)) 

w = 1

while w**2 <= len(rawNums):
    if w**2 == len(rawNums):
        width = w
        loop = False
    w += 1

#scriptName  = os.path.basename(sys.argv[0])
errorString = os.path.basename(sys.argv[0]) + ' requires a command-line argument. There are modes for 0, 90, 180, and 270 degree rotations.\n'

if not len(sys.argv[1:]):
     sys.stderr.write(errorString)
     exit(1)

deg = sys.argv[1]

if not re.search(r'\A[012789]+\Z',deg):
    sys.stderr.write(errorString)
    exit(1)

deg = int(deg)        

if not (deg == 0 or deg == 90 or deg == 180 or deg == 270):
    sys.stderr.write('Invalid choice. There are modes for 0, 90, 180, and 270 degrees.\n')
    exit(1)

newMatrix = arr = [[0 for i in range(width)] for j in range(width)] 
i = 0

if deg == 0:
    for j in range(width):
        for k in range(width):
            # print('j: ', j,'k: ', k,'i: ', i,'rawNums[i]: ', rawNums[i])
            newMatrix[j][k] = rawNums[i]
            i += 1

elif deg == 90:
     for j in range(width-1, -1, -1):
         for k in range(width):
             newMatrix[k][j] = rawNums[i]
             i += 1

elif deg == 180:
    for j in range(width-1, -1, -1):
        for k in range(width-1, -1, -1):
            newMatrix[j][k] = rawNums[i]
            i += 1
            
elif deg == 270:
    for j in range(width):
        for k in range(width-1, -1, -1):            
            newMatrix[k][j] = rawNums[i]
            i += 1

[print(whoa) for whoa in newMatrix]




#!/usr/bin/env python3
#
#
#       max-gap.py
#
#         TASK #1 › Maximum Gap
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers @N.
# 
#         Write a script to display the maximum difference between two successive 
#         elements once the array is sorted.
# 
#         If the array contains only 1 element then display 0.
# 
#         Example
# 
#             Input: @N = (2, 9, 3, 5)
#             Output: 4
# 
#             Input: @N = (1, 3, 8, 2, 0)
#             Output: 5
# 
#             Input: @N = (5)
#             Output: 0
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



import sys

def gapIndexed( list ):
    list = sorted(list)
    i    = 1
    gap  = 0
    while i < len(list):
        gap = max( gap, int(list[i]) - int(list[i-1]) )
        i += 1
    return gap
    
input = sys.argv[1:]
print( "input array: ", input )
gap = gapIndexed( input );
print( "maximum gap: ", gap )




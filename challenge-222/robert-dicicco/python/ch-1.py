#!/usr/bin/env python
# -----------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-06-19
# Challenge 222 Task 1 Matching Members ( Python )
# -----------------------------------------------
allints = [[1, 1, 4, 2, 1, 3],[5, 1, 2, 3, 4],[1, 2, 3, 4, 5]]

for ints in allints:
    print("Input: @ints = ",ints)
    flag = 0
    sortd = sorted(ints)
    cnt = 0
    while cnt < len(ints):
        if ints[cnt] == sortd[cnt]:
            flag += 1
        cnt += 1
    print("Output: ",flag,"\n")

 # -----------------------------------------------
 # SAMPLE OUTPUT
 # python .\MatchingMembers.py

# Input: @ints =  [1, 1, 4, 2, 1, 3]
# Output:  3

# Input: @ints =  [5, 1, 2, 3, 4]
# Output:  0

# Input: @ints =  [1, 2, 3, 4, 5]
# Output:  5
 # -----------------------------------------------



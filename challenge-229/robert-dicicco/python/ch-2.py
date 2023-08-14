#!/usr/bin/env python
# ------------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-08-09
# Challenge 229 Two Out Of Three  Task 2 ( Python )
# ------------------------------------------------

import sys
#arrays = [[1, 1, 2, 4,],[2, 4],[4]]
arrays = [[4, 1],[2, 4],[1, 2]]

hash = dict()
cnt = 1

def unique(list1):
    unique_list = []
    for x in list1:
        if x not in unique_list:
            unique_list.append(x)
    return unique_list


def CreateCounts(a):
    for i in a:
        if i in hash:
            hash[i] += 1
        else:
            hash[i] = 1

for a in arrays:
    a = unique(a)
    if cnt == 1:
        array1 = a
        CreateCounts(array1)
        print(f"Input:  @array1 = {array1}")
    elif cnt == 2:
        array2 = a
        CreateCounts(array2)
        print(f"\t@array2 = {array2}")
    elif cnt == 3:
        array3 = a
        CreateCounts(array3)
        print(f"\t@array3 = {array3}")
    else:
        print("ERROR!")
        sys.exit(1)

    cnt += 1

print("Output: [",end=" ")
for key in hash:
    if hash[key] >= 2:
        print(key,end=" ")
print("]\n")

# ------------------------------------------------
# SAMPLE OUTPUT
# python .\TwoThree.py
# Input:  @array1 = [1, 2, 4]
        # @array2 = [2, 4]
        # @array3 = [4]
# Output: [ 2 4 ]

# python .\TwoThree.py
# Input:  @array1 = [4, 1]
        # @array2 = [2, 4]
        # @array3 = [1, 2]
# Output: [ 4 1 2 ]
# ------------------------------------------------


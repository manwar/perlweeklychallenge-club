# Task 2: Widest Valley
# Submitted by: E. Choroba
# 
# Given a profile as a list of altitudes, return the leftmost widest valley. A valley is defined as a subarray of the profile consisting of two parts: the first part is non-increasing and the second part is non-decreasing. Either part can be empty.
# 
# Example 1
# Input: 1, 5, 5, 2, 8
# Output: 5, 5, 2, 8
# 
# Example 2
# Input: 2, 6, 8, 5
# Output: 2, 6, 8
# 
# Example 3
# Input: 9, 8, 13, 13, 2, 2, 15, 17
# Output: 13, 13, 2, 2, 15, 17
# 
# Example 4
# Input: 2, 1, 2, 1, 3
# Output: 2, 1, 2
# 
# Example 5
# Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
# Output: 3, 3, 2, 1, 2, 3, 3

import re
import sys

def check_valley(arr):
    index_left = 0
    index_right = len(arr)-1

    for index in range(1, len(arr)):
        if arr[index_left] < arr[index]:
            break
        index_left = index
    for index in range(index_left, len(arr)-1)[::-1]:
        if arr[index_right] < arr[index]:
            break
        index_right = index

    if index_right == index_left:
        return 1
    else:
        return 0
    

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 1 or
        len(list(filter(lambda x: re.search(r'\D', x), input))) > 0 ):
        sys.exit("Input error\n")
    input = [int(x) for x in input] 

    valleys = []
    for left in range(len(input)):
        for right in range(left, len(input))[::-1]:
            subarray = input[left:right+1]
            if check_valley(subarray):
                valleys.append((len(subarray), left, subarray))

    widest = max(v[0] for v in valleys)
    leftmost = min(v[1] for v in valleys if v[0] == widest)
    valley = [v for v in valleys if v[0] == widest and v[1] == leftmost][0]
    print(', '.join(map(str, valley[2])))

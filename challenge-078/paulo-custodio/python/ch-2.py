#!/usr/bin/python3

# Challenge 078
#
# TASK #2 > Left Rotation
# Submitted by: Mohammad S Anwar
# You are given array @A containing positive numbers and @B containing one or
# more indices from the array @A.
#
# Write a script to left rotate @A so that the number at the first index of @B
# becomes the first element in the array.
# Similarly, left rotate @A again so that the number at the second index of @B
# becomes the first element in the array.
#
# Example 1:
# Input:
#     @A = (10 20 30 40 50)
#     @B = (3 4)
# Explanation:
# a) We left rotate the 3rd index element (40) in the @A to make it 0th index
#    member in the array.
#         [40 50 10 20 30]
#
# b) We left rotate the 4th index element (50) in the @A to make it 0th index
#    member in the array.
#         [50 10 20 30 40]
#
# Output:
#     [40 50 10 20 30]
#     [50 10 20 30 40]
# Example 2:
# Input:
#     @A = (7 4 2 6 3)
#     @B = (1 3 4)
# Explanation:
# a) We left rotate the 1st index element (4) in the @A to make it 0th index
#    member in the array.
#         [4 2 6 3 7]
#
# b) We left rotate the 3rd index element (6) in the @A to make it 0th index
#    member in the array.
#         [6 3 7 4 2]
#
# c) We left rotate the 4th index element (3) in the @A to make it 0th index
#    member in the array.
#         [3 7 4 2 6]
#
# Output:
#     [4 2 6 3 7]
#     [6 3 7 4 2]
#     [3 7 4 2 6]

import sys

A = [int(x) for x in sys.argv[1].split()]
B = [int(x) for x in sys.argv[2].split()]

for i in B:
    a = [*A[i:], *A[:i]]
    print("["+" ".join([str(x) for x in a])+"]")

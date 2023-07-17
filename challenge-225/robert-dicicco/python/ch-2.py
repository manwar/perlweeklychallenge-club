#!/usr/bin/env python
# ---------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-07-11
# Challenge 225 Task 2 Left Right Sum Diff ( Python )
# ---------------------------------------

arrays = [[1, 2, 3, 4, 5],[10,4,8,3]]
left = []
right = []
left_right_sum_diff = []

def ltr(array):
    sum = 0
    left.append(0)
    ln = len(array)
    for x in range(0,ln-1):
        sum += array[x]
        left.append(sum)
    print(f"\t@left = {left}")

def rtl(array):
    sum = 0
    right.append(0)
    i = len(array) - 1
    while i > 0 :
        sum += array[i]
        right.append(sum)
        i -= 1
    right.reverse()
    print(f"\t@right = {right}")


for arr in arrays:
    print(f"Input: @ints = {arr}")
    ltr(arr)
    rtl(arr)

    i = 0
    while i < len(arr):
        val = abs(left[i] - right[i])
        left_right_sum_diff.append(val)
        i += 1
    left = []
    right = []
    print(f"\tOutput: @left_right_sum_diff = {left_right_sum_diff}\n")
    left_right_sum_diff = []
# ---------------------------------------
# SAMPLE OUTPUT
 # python LRSD.py
# Input: @ints = [1, 2, 3, 4, 5]
        # @left = [0, 1, 3, 6, 10]
        # @right = [14, 12, 9, 5, 0]
        # Output: @left_right_sum_diff = [14, 11, 6, 1, 10]

# Input: @ints = [10, 4, 8, 3]
        # @left = [0, 10, 14, 22]
        # @right = [15, 11, 3, 0]
        # Output: @left_right_sum_diff = [15, 1, 11, 22]
# ---------------------------------------






#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/#TASK2
#
# Task 2: Unique Sum Zero
# =======================
#
# You are given an integer, $n.
#
# Write a script to find an array containing $n unique integers such that they
# add up to zero.
#
## Example 1
##
## Input: $n = 5
## Output: (-7, -1, 1, 3, 4)
##
## Two other possible solutions could be as below:
## (-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).
#
## Example 2
##
## Input: $n = 3
## Output: (-1, 0, 1)
#
## Example 3
##
## Input: $n = 1
## Output: (0)
#
############################################################
##
## discussion
##
############################################################
#
# Since we only need to find one array with unique integers, we can
# simply use one with both i and -i in it, with |i| growing, starting
# at 1. In case of an odd number we just add 0 to the array.

def unique_sum_zero(n: int) -> list:
    result = []
    print(f"Input: {n}")
    if n == 0:
        print("Output: ()")
        return
    if n % 2 == 0:
        val = n / 2
        for i in range(1, int(val+1)):
            result.append(i)
            result.append(-i)
    else:
        val = int(n / 2)
        result.append(0)
        for i in range(1, int(val+1)):
            result.append(i)
            result.append(-i)
    print("Output: (", ", ".join([str(x) for x in result]), ")")
    return result

unique_sum_zero(5)
unique_sum_zero(3)
unique_sum_zero(1)
unique_sum_zero(2)
unique_sum_zero(4)
unique_sum_zero(0)



#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-251/#TASK1
#
# Task 1: Concatenation Value
# ===========================
#
# You are given an array of integers, @ints.
#
# Write a script to find the concatenation value of the given array.
#
# The concatenation of two numbers is the number formed by concatenating their
# numerals.
#
## For example, the concatenation of 10, 21 is 1021.
## The concatenation value of @ints is initially equal to 0.
## Perform this operation until @ints becomes empty:
##
## If there exists more than one number in @ints, pick the first element
## and last element in @ints respectively and add the value of their
## concatenation to the concatenation value of @ints, then delete the
## first and last element from @ints.
##
## If one element exists, add its value to the concatenation value of
## @ints, then delete it.
#
## Example 1
##
## Input: @ints = (6, 12, 25, 1)
## Output: 1286
##
## 1st operation: concatenation of 6 and 1 is 61
## 2nd operation: concaternation of 12 and 25 is 1225
##
## Concatenation Value => 61 + 1225 => 1286
#
## Example 2
##
## Input: @ints = (10, 7, 31, 5, 2, 2)
## Output: 489
##
## 1st operation: concatenation of 10 and 2 is 102
## 2nd operation: concatenation of 7 and 2 is 72
## 3rd operation: concatenation of 31 and 5 is 315
##
## Concatenation Value => 102 + 72 + 315 => 489
#
## Example 3
##
## Input: @ints = (1, 2, 10)
## Output: 112
##
## 1st operation: concatenation of 1 and 10 is 110
## 2nd operation: only element left is 2
##
## Concatenation Value => 110 + 2 => 112
#
############################################################
##
## discussion
##
############################################################
#
# Starting with a sum of 0, we call a function that just concatenates
# the first and last elements of @ints and adds that number to the
# current sum, then we call the function recursively with the new
# current sum and the remainder of the array. Of course handle the
# case where there is only one element in the array by returning the
# current sum + the last element, and the case of an empty array by
# returning the current sum.

def concatenation_value_(current: int, ints: list) -> int:
    if len(ints) == 0:
        return current
    if len(ints) == 1:
        return current + ints[0]
    value = str(ints[0]) + str(ints[-1])
    return concatenation_value_(current + int(value), ints[1:-1])

def concatenation_value(ints: list) -> None:
    print("Input: (", ", ".join([str(x) for x in ints]), ")")
    result = concatenation_value_(0, ints)
    print(f"Output: {result}")

concatenation_value([6, 12, 25, 1])
concatenation_value([10, 7, 31, 5, 2, 2])
concatenation_value([1, 2, 10])


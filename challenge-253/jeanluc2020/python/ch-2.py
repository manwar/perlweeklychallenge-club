#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/#TASK2
#
# Task 2: Weakest Row
# ===================
#
# You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear before 0.
#
# A row i is weaker than a row j if one of the following is true:
#
## a) The number of 1s in row i is less than the number of 1s in row j.
## b) Both rows have the same number of 1 and i < j.
#
# Write a script to return the order of rows from weakest to strongest.
#
## Example 1
##
## Input: $matrix = [
##                    [1, 1, 0, 0, 0],
##                    [1, 1, 1, 1, 0],
##                    [1, 0, 0, 0, 0],
##                    [1, 1, 0, 0, 0],
##                    [1, 1, 1, 1, 1]
##                  ]
## Output: (2, 0, 3, 1, 4)
##
## The number of 1s in each row is:
## - Row 0: 2
## - Row 1: 4
## - Row 2: 1
## - Row 3: 2
## - Row 4: 5
#
## Example 2
##
## Input: $matrix = [
##                    [1, 0, 0, 0],
##                    [1, 1, 1, 1],
##                    [1, 0, 0, 0],
##                    [1, 0, 0, 0]
##                  ]
## Output: (0, 2, 3, 1)
##
## The number of 1s in each row is:
## - Row 0: 1
## - Row 1: 4
## - Row 2: 1
## - Row 3: 1
#
############################################################
##
## discussion
##
############################################################
#
# First, we create a second array which contains the number of 1's
# in each row and the row's index, then we sort that array by the
# number of ones and the index - which means we only sort by the
# number of ones since python's sort is stable, keeping the order
# of elements intact if the values are the same, and the index is
# therefore already sorted after sorting by number of ones.
#

from operator import itemgetter

def number_of_ones( array: list) -> int:
    output = 0
    for value in array:
        if value > 0:
            output += 1
    return output

def weakest_row(matrix: list) -> None:
    print("Input: [")
    for array in matrix:
        print("         [", ", ".join([str(x) for x in array]), "],")
    print("       ]")
    sort_by_me = []
    i = 0
    for array in matrix:
        num = number_of_ones(array)
        pos = i
        i += 1
        sort_by_me.append([num, pos])
    sorted_array = sorted(sort_by_me, key=itemgetter(0))
    print("Output: (", ", ".join([str(x[1]) for x in sorted_array]), ")", sep=None)


weakest_row([ [1, 1, 0, 0, 0], [1, 1, 1, 1, 0], [1, 0, 0, 0, 0], [1, 1, 0, 0, 0], [1, 1, 1, 1, 1] ])
weakest_row([ [1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0] ])


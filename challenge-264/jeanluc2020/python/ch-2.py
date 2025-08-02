#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/#TASK2
#
# Task 2: Target Array
# ====================
#
# You are given two arrays of integers, @source and @indices. The @indices can
# only contains integers 0 <= i < size of @source.
#
# Write a script to create target array by insert at index $indices[i] the
# value $source[i].
#
## Example 1
##
## Input: @source  = (0, 1, 2, 3, 4)
##        @indices = (0, 1, 2, 2, 1)
## Output: (0, 4, 1, 3, 2)
##
## @source  @indices  @target
## 0        0         (0)
## 1        1         (0, 1)
## 2        2         (0, 1, 2)
## 3        2         (0, 1, 3, 2)
## 4        1         (0, 4, 1, 3, 2)
#
## Example 2
##
## Input: @source  = (1, 2, 3, 4, 0)
##        @indices = (0, 1, 2, 3, 0)
## Output: (0, 1, 2, 3, 4)
##
## @source  @indices  @target
## 1        0         (1)
## 2        1         (1, 2)
## 3        2         (1, 2, 3)
## 4        3         (1, 2, 3, 4)
## 0        0         (0, 1, 2, 3, 4)
#
## Example 3
##
## Input: @source  = (1)
##        @indices = (0)
## Output: (1)
#
############################################################
##
## discussion
##
############################################################
#
# Walk the arrays in parallel using an index $i; insert
# source[i] at the index indices[i] in the target array

def target_array(source: list, indices: list) -> None:
    print("Input: (", ", ".join([str(x) for x in source]), "), (", ", ".join([str(x) for x in indices]), ")", sep="")
    target = []
    for i in range(len(indices)):
        target.insert(indices[i], source[i])
    print("Output: (", ", ".join([str(x) for x in target]), ")", sep="")

target_array( [0, 1, 2, 3, 4], [0, 1, 2, 2, 1] );
target_array( [1, 2, 3, 4, 0], [0, 1, 2, 3, 0] );
target_array( [1], [0] );


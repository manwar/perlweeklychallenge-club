#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/#TASK2
#
# Task 2: Merge Items
# ===================
#
# You are given two 2-D array of positive integers, $items1 and $items2 where
# element is pair of (item_id, item_quantity).
#
# Write a script to return the merged items.
#
## Example 1
##
## Input: $items1 = [ [1,1], [2,1], [3,2] ]
##        $items2 = [ [2,2], [1,3] ]
## Output: [ [1,4], [2,3], [3,2] ]
##
## Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
## Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
## Item id (3) appears 1 time: [3,2]
#
## Example 2
##
## Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
##        $items2 = [ [3,1], [1,3] ]
## Output: [ [1,8], [2,3], [3,3] ]
#
## Example 3
##
## Input: $items1 = [ [1,1], [2,2], [3,3] ]
##        $items2 = [ [2,3], [2,4] ]
## Output: [ [1,1], [2,9], [3,3] ]
#
############################################################
##
## discussion
##
############################################################
#
# For this one, actually printing input and output is a little
# more tricky than the actual algorithm: Simply walk the combination
# of both arrays, and for each entry use the first element of that
# as the key of a result hash and the second element as what to add
# to the value of that entry in the hash. Print the result sorted
# by the hash keys.

def merge_items(items1: list, items2: list) -> None:
    result = {}
    print("Input: items1 = [ ", end="")
    for elem in items1:
        print("[", elem[0], ", ", elem[1], "], ", sep="", end="")
    print("],")
    print("       items2 = [", end="")
    for elem in items1:
        print("[", elem[0], ", ", elem[1], "], ", sep="", end="")
    print("]")

    all = items1
    for x in items2:
        all.append(x)
    for elem in all:
        if elem[0] in result:
            result[elem[0]] += elem[1]
        else:
            result[elem[0]] = elem[1]

    print("Output: [", end="")
    for elem in sorted(result):
        print("[", elem, ", ", result[elem], "], ", sep="", end="")
    print("]")

merge_items( [ [1,1], [2,1], [3,2] ], [ [2,2], [1,3] ] );
merge_items( [ [1,2], [2,3], [1,3], [3,2] ], [ [3,1], [1,3] ] );
merge_items( [ [1,1], [2,2], [3,3] ], [ [2,3], [2,4] ] );


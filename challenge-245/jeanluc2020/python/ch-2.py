#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK2
#
# Task 2: Largest of Three
# ========================
#
# You are given an array of integers >= 0.
#
# Write a script to return the largest number formed by concatenating some of
# the given integers in any order which is also multiple of 3. Return -1 if
# none found.
#
## Example 1
##
## Input: @ints = (8, 1, 9)
## Output: 981
##
## 981 % 3 == 0
#
## Example 2
##
## Input: @ints = (8, 6, 7, 1, 0)
## Output: 8760
#
## Example 3
##
## Input: @ints = (1)
## Output: -1
#
############################################################
##
## discussion
##
############################################################
#
# While all examples in the description use single-digit numbers,
# there is nothing that would require this. So in order to catch all
# solutions, we need all possible permutations of all subsets of the
# array and of the numbers created out of those we need the biggest
# one that is divisible by 3.

from itertools import chain, combinations, permutations

def powerset(iterable):
    "powerset([1,2,3]) → () (1,) (2,) (3,) (1,2) (1,3) (2,3) (1,2,3)"
    s = list(iterable)
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def largest_of_three(ints: list):
    print("Input: (", ", ".join(str(x) for x in ints), ")")
    result = int()
    for myset in powerset(ints):
        for c in permutations(myset, len(myset)):
            v = str("".join(str(x) for x in c))
            # print("-> ", v)
            if len(v) > 0:
                # print("Considering", v, "as a value")
                value = int(v)
                if value % 3 == 0:
                    if len(str(result)) == 0:
                        result = value
                    if value > result:
                        result = value
    if len(str(result)) == 0:
        print("Output: -1")
    else:
        print("Output:", str(result))

largest_of_three([8, 1, 9]);
largest_of_three([8, 6, 7, 1, 0]);
largest_of_three([1]);
largest_of_three([8, 60, 7]);
largest_of_three([80, 6, 7]);


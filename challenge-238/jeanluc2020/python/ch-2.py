#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-238/#TASK2
#
# Task 2: Persistence Sort
# ========================
#
# You are given an array of positive integers.
#
# Write a script to sort the given array in increasing order with respect to
# the count of steps required to obtain a single-digit number by multiplying
# its digits recursively for each array element. If any two numbers have the
# same count of steps, then print the smaller number first.
#
## Example 1
##
## Input: @int = (15, 99, 1, 34)
## Output: (1, 15, 34, 99)
##
## 15 => 1 x 5 => 5 (1 step)
## 99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
## 1  => 0 step
## 34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)
#
## Example 2
##
## Input: @int = (50, 25, 33, 22)
## Output: (22, 33, 50, 25)
##
## 50 => 5 x 0 => 0 (1 step)
## 25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
## 33 => 3 x 3 => 6 (1 step)
## 22 => 2 x 2 => 4 (1 step)
#
############################################################
##
## discussion
##
############################################################
#
# Create a temporary list that contains a list for each
# element. The list consists of the int and the persistence
# Then we just need to sort by persistence, then by the number

from operator import itemgetter

def persistence(number: int) -> int:
    digits = [int(d) for d in str(number)]
    if len(digits) <= 1:
        return 0
    prod = 1
    for d in digits:
        prod *= d
    return 1 + persistence(prod)


def persistence_sort(ints: list):
    print("Input: (" , ", ".join(str(x) for x in ints), ")")
    tmp = []
    for x in ints:
        tmp.append( (x, persistence(x)) )
    s = sorted(tmp, key=itemgetter(1))
    s = sorted(s, key=itemgetter(0))
    #s = sorted(s)
    print("Output: (" , ", ".join(str(x[0]) for x in s), ")")

persistence_sort([15, 99, 1, 34])
persistence_sort([50, 25, 33, 22])

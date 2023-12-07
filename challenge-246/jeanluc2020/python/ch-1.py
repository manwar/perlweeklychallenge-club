#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/#TASK1
#
# Task 1: 6 out of 49
# ===================
#
# 6 out of 49 is a German lottery.
#
# Write a script that outputs six unique random integers from the range 1 to
# 49.
#
## Output
##
## 3
## 10
## 11
## 22
## 38
## 49
#
############################################################
##
## discussion
##
############################################################
#
# Collect random numbers until we have 6 of them. In case we randomly select a
# number that we saw already, discard the number and select another random
# number instead.
#
import random

result = {}

def next_rand() -> int:
    res = random.randint(1,49)
    if res in result:
        # collision, calculate a new random number
        return next_rand()
    return res

for i in range(6):
    num = next_rand()
    result[num] = 1

print("\n".join(str(x) for x in sorted(result.keys())))


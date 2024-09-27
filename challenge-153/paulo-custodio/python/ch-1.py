#!/usr/bin/env python3

# Challenge 153
#
# TASK #1 > Left Factorials
# Submitted by: Mohammad S Anwar
# Write a script to compute Left Factorials of 1 to 10. Please refer
# OEIS A003422 for more information.
#
# Expected Output:
# 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114

def fact(n):
    if n < 2:
        return 1
    else:
        return n * fact(n-1)

def left_fact(n):
    sum = 0
    for k in range(n):
        sum += fact(k)
    return sum

out = [left_fact(x) for x in range(1, 10+1)]
print(", ".join(map(str, out)))

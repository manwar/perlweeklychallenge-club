#!/usr/bin/env python3

# Challenge 147
#
# TASK #2 > Pentagon Numbers
# Submitted by: Mohammad S Anwar
# Write a script to find the first pair of Pentagon Numbers whose sum and
# difference are also a Pentagon Number.
#
# Pentagon numbers can be defined as P(n) = n(3n - 1)/2.
#
# Example
# The first 10 Pentagon Numbers are:
# 1, 5, 12, 22, 35, 51, 70, 92, 117 and 145.
#
# P(4) + P(7) = 22 + 70 = 92 = P(8)
# but
# P(4) - P(7) = |22 - 70| = 48 is not a Pentagon Number.

limit = 100_000_000

pentagon = [1]
is_pentagon = {}

def find_pair():
    is_pentagon_func(limit)  # build pentagon up to N
    try_ = pentagon.copy()
    for a in try_:
        for b in try_:
            if is_pentagon_func(a + b) and is_pentagon_func(abs(a - b)):
                return a, b
    raise Exception("No pair found")

def is_pentagon_func(num):
    while pentagon[-1] < num:
        n = len(pentagon) + 1
        p = n * (3 * n - 1) // 2
        pentagon.append(p)
        is_pentagon[p] = True
    return is_pentagon.get(num, False)

a, b = find_pair()
print(f"({a},{b})")

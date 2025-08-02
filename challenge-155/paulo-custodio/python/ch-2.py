#!/usr/bin/env python3

# Challenge 155
#
# TASK #2 > Pisano Period
# Submitted by: Mohammad S Anwar
# Write a script to find the period of the 3rd Pisano Period.
#
# In number theory, the nth Pisano period, written as p(n), is the period with
# which the sequence of Fibonacci numbers taken modulo n repeats.
#
# The Fibonacci numbers are the numbers in the integer sequence:
#
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, ...
# For any integer n, the sequence of Fibonacci numbers F(i) taken modulo n is
# periodic. The Pisano period, denoted p(n), is the value of the period of this
# sequence. For example, the sequence of Fibonacci numbers modulo 3 begins:
#
# 0, 1, 1, 2, 0, 2, 2, 1,
# 0, 1, 1, 2, 0, 2, 2, 1,
# 0, 1, 1, 2, 0, 2, 2, 1, ...
# This sequence has period 8, so p(3) = 8.

from math import isqrt

order = 3

def fibonacci_series(n):
    fibs = [0, 1]
    for i in range(2, n):
        fibs.append(fibs[-1] + fibs[-2])
    return fibs

def is_period(period, n):
    base = n[0:period]
    ord1 = n[period:2*period]
    ord2 = n[2*period:3*period]

    if base != ord1:
        return 0
    if base != ord2:
        return 0
    return 1

def find_period(n):
    period = 1
    while True:
        if 3 * period > len(n):
            return 0
        if is_period(period, n):
            return period
        period += 1
    return 0

fibs = fibonacci_series(100)
fibs_mod = [fib % order for fib in fibs]
print(find_period(fibs_mod))

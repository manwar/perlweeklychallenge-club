#!/usr/bin/python3

# Challenge 141
#
# TASK #1 > Number Divisors
# Submitted by: Mohammad S Anwar
# Write a script to find lowest 10 positive integers having exactly 8 divisors.
#
# Example
# 24 is the first such number having exactly 8 divisors.
# 1, 2, 3, 4, 6, 8, 12 and 24.

import sys
import math

NUM_DIVISORS = 8

def divisors(n):
    div_low = []
    div_high = []
    for i in range(1, int(math.sqrt(n)+1)):
        if n%i==0:
            div_low.append(i)
            if n/i!=i:
                div_high.append(int(n/i))
    div_high = div_high[::-1]
    return [*div_low, *div_high]

def next_number(n):
    while True:
        n += 1
        divs = divisors(n)
        if len(divs)==NUM_DIVISORS:
            return n

num = int(sys.argv[1])
n = 0
for i in range(num):
    n = next_number(n)
    print(n)

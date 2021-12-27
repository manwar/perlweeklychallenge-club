#!/usr/bin/env python3

# Challenge 139
#
# TASK #2 > Long Primes
# Submitted by: Mohammad S Anwar
# Write a script to generate first 5 Long Primes.
#
# A prime number (p) is called Long Prime if (1/p) has an infinite decimal
# expansion repeating every (p-1) digits.
#
# Example
# 7 is a long prime since 1/7 = 0.142857142857...
# The repeating part (142857) size is 6 i.e. one less than the prime number 7.
#
# Also 17 is a long prime since 1/17 = 0.05882352941176470588235294117647...
# The repeating part (0588235294117647) size is 16 i.e. one less than the
# prime number 17.
#
# Another example, 2 is not a long prime as 1/2 = 0.5.
# There is no repeating part in this case.

import sys
import re
from decimal import *

getcontext().prec = 1000
getcontext().rounding = ROUND_DOWN

def is_prime(n):
    if n <= 1:
        return 0
    elif n <= 3:
        return 1
    elif n % 2 == 0 or n % 3 == 0:
        return 0
    else:
        for i in range(5, n+1, 6):
            if i*i>n:
                break
            if n % i == 0 or n % (i+2) == 0:
                return 0
        return 1

def rept_sequence(n, max):
    #print("rept_sequence", n, max)
    for rept in range(1, max+1):
        if re.search(r"\.(\d{"+str(rept)+r"})\1+", str(n)):
            #print(rept)
            return rept
    #print(-1)
    return -1

def is_long_prime(p):
    if not is_prime(p):
        return False
    inv = Decimal(1) / Decimal(p)
    #print("check", inv, p, rept_sequence(inv, p-1))
    if rept_sequence(inv, p-1)==p-1:
        return True
    else:
        return False

def print_long_primes(n):
    p = 2
    for i in range(n):
        while not is_long_prime(p):
            p += 1
        print(p)
        p += 1

print_long_primes(int(sys.argv[1]))

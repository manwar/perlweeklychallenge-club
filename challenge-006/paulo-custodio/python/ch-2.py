#!/usr/bin/env python3

# Challenge 006
#
# Challenge #2
# Create a script to calculate Ramanujan's constant with at least 32 digits of
# precision. Find out more about it here.
#
# The standard IEEE 754 double-precision binary floating-point format: binary64
# gives only 15 to 17 significant decimal digits
# Therefore must use the bignum library

from decimal import *

getcontext().prec = 128

def pi():
    getcontext().prec += 2  # extra digits for intermediate steps
    three = Decimal(3)      # substitute "three=3.0" for regular floats
    lasts, t, s, n, na, d, da = 0, three, 3, 1, 0, 0, 24
    while s != lasts:
        lasts = s
        n, na = n+na, na+8
        d, da = d+da, da+32
        t = (t * n) / d
        s += t
    getcontext().prec -= 2
    return +s               # unary plus applies the new precision

def exp(x):
    getcontext().prec += 2
    i, lasts, s, fact, num = 0, 0, 1, 1, 1
    while s != lasts:
        lasts = s
        i += 1
        fact *= i
        num *= x
        s += num / fact
    getcontext().prec -= 2
    return +s

e = pi() * Decimal(163).sqrt()
k = exp(e)

print(str(k)[:31])

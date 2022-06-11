#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: python ch-1.py < input-file
#


def digit_sum (number):
    sum  =  0
    base = 10
    while number > 0:
        sum    = sum + number % base
        number = number // base
    return sum

fib            = {}
fib_prev       = 0
fib_last       = 1
fib [fib_prev] = True;
fib [fib_last] = True;

def is_fib (n):
    global fib, fib_prev, fib_last
    while fib_last < n:
        t        = fib_last
        fib_last = fib_last + fib_prev
        fib_prev = t
        fib [fib_last] = True;
    return n in fib

import fileinput, sys

for n in fileinput . input ():
    n = int (n)
    k = 0
    while n > 0:
        if is_fib (digit_sum (k)):
            sys . stdout . write (str (k) + " ")
            n = n - 1
        k = k + 1
    print ("")

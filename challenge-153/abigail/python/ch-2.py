#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

fac = [1] * 10
for n in range (1, 10):
    fac [n] = n * fac [n - 1]

for line in fileinput . input ():
    num = int (line)
    sum = 0
    n   = num
    while n > 0:
        sum = sum + fac [n % 10]
        n   = n // 10

    if num == sum:
        print (1)
    else:
        print (0)

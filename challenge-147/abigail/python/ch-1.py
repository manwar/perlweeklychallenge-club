#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: python ch-1.py
#

import sys
from sympy import isprime

todo = [2, 3, 5, 7]
[sys . stdout . write (str (x) + " ") for x in todo]
count = 20 - len (todo)

pow = 10
while count > 0:
    new_todo = []
    for d in range (1, 10):
        for p in todo:
            candidate = d * pow + p
            if isprime (candidate):
                sys . stdout . write (str (candidate) + " ")
                count = count - 1
                new_todo . append (candidate)
                if count <= 0:
                    break
            if count <= 0:
                break
        if count <= 0:
            break
    todo = new_todo
    pow  = pow * 10

sys . stdout . write ("\n")

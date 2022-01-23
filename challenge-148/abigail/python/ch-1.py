#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: python ch-1.py
#

import sys, re

for i in range (101):
    if not (i == 0 or re . search (r'[1789]', str (i)) 
                   or re . search (r'^2.',    str (i))
                   or re . search (r'[35]$',  str (i))):
        sys . stdout . write (str (i) + " ")

sys . stdout . write ("\n")

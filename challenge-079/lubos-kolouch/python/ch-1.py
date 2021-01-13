#!/bin/env python
"""
===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge Task 1
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#               Count set bits
#
#       AUTHOR: Lubos Kolouch
#==============================================================================
"""


def get_dec2bin(what: int):
    """ Get the number of set 1s """

    count = 0
    for i in range(1, what+1):
        mod_str = str(bin(i))[2:]
        count += sum(list(map(int, mod_str)))

    return count


assert get_dec2bin(4) == 5
assert get_dec2bin(3) == 4

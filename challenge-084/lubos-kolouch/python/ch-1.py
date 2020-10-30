#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge #84
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/
#               Task 1 - Reverse Integer
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 10/28/2020 08:48:14 PM
#===============================================================================
"""


def get_reverse_int(what: int):
    """ Reverse the int """

    # sanitize the input to int
    what = int(what)

    sign = '-' if what < 0 else ''

    rever = str(abs(what))[::-1]

    # 33 because it starts with 0b
    if len(bin(int(rever))) > 33:
        return 0

    return int(sign+rever)


assert get_reverse_int(1234) == 4321
assert get_reverse_int(-1234) == -4321
assert get_reverse_int(1_231_230_512) == 0
assert get_reverse_int(1.000) == 1
assert get_reverse_int(1e+3) == 1
assert get_reverse_int(7_463_847_412) == 2_147_483_647
assert get_reverse_int(2_147_483_648) == 0

#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge #102
#               Task 1 - Rare Numbers
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 03/06/2021 11:18:30 AM
#===============================================================================
"""
from math import sqrt


def get_rare_numbers(what: int):
    """ Get all rare number in the give range """

    pos = '1' + '0'*(what-1)

    output = []
    while 1:
        pos = str(int(pos)+1)

        if len(pos) > what:
            break

        rev_num = pos[::-1]

        if int(pos) - int(rev_num) <= 0:
            continue

        if sqrt(int(pos) - int(rev_num)) != int(sqrt(int(pos) - int(rev_num))):
            continue

        if sqrt(int(pos) + int(rev_num)) != int(sqrt(int(pos) + int(rev_num))):
            continue

        print(pos)

        output.append(int(pos))

    return output


assert get_rare_numbers(2) == [65]
assert get_rare_numbers(6) == [621770]
assert get_rare_numbers(9) == [281089082]

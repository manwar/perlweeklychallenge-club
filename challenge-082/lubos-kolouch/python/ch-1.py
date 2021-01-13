#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge 082
#               http://www.perlweeklychallenge.org
#               Task 1 - Common Factors
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 10/15/2020 07:25:23 PM
#===============================================================================
"""
import math


def get_common_factors(numbers):

    # 1 is always factor
    common_factors = [1]

    # it's enough to to go sqrt of one of the numbers
    for i in range(2, int(math.sqrt(numbers['first'])+1)):
        if numbers['first'] % i != 0:
            continue

        # add to solution if it is factor of the second number
        if numbers['second'] % i == 0:
            common_factors.append(i)

        # the same for the "other factor"
        other_factor = numbers['first'] // i
        if numbers['second'] % other_factor == 0:
            common_factors.append(other_factor)

    common_factors.sort(key=int)
    return common_factors


assert get_common_factors({'first': 12, 'second': 18}) == [1, 2, 3, 6]
assert get_common_factors({'first': 18, 'second': 23}) == [1]
assert get_common_factors({'first': 1, 'second': 1}) == [1]

#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: Perl Weekly Challenge 082
#               http://www.perlweeklychallenge.org
#               Task 2 - Interleave String
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 10/17/2020 07:25:23 PM
#===============================================================================
"""


def inter_leave(a: str, b: str, current: str = '', result=dict()):
    """ Do the interleave """
    if not a and not b:
        result[current] = 1
        return result

    if a:
        result = inter_leave(a=a[1:], b=b, current=current+a[0], result=result)

    if b:
        result = inter_leave(a=a, b=b[1:], current=current+b[0], result=result)

    return result


def can_interleave(a: str, b: str, c: str):
    """ Find out if the string can be interleaved """

    if len(a) + len(b) != len(c):
        return 0

    result = inter_leave(a=a, b=b, result=dict())
    return result.get(c, 0)


assert can_interleave(a='XY', b='X', c='XXY') == 1
assert can_interleave(a='XXY', b='XXZ', c='XXXXZY') == 1
assert can_interleave(a='YX', b='X', c='XXY') == 0
assert can_interleave(a='XXY', b='X', c='XXY') == 0

#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.p
#
#  DESCRIPTION: Perl Weekly Challenge #102
#               Task 2 - Hash-counting String
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 03/06/2021 11:18:30 AM
#===============================================================================
"""


def get_hash(what: int):
    """ get the hash """
    # we know the last position has length
    # of the input. So we can just backtrack
    output = ''

    pos = what
    while pos > 0:
        append_str = str(pos)+'#'

        if pos > 1:
            output = str(pos)+'#'+output
        else:
            output = '#'+output

        pos = int(pos) - len(append_str)

    return output


assert get_hash(1) == '#'
assert get_hash(2) == '2#'
assert get_hash(3) == '#3#'
assert get_hash(10) == '#3#5#7#10#'
assert get_hash(14) == '2#4#6#8#11#14#'

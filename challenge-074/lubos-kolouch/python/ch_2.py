#!/usr/bin/env python
""" FNR character from Perl weekly challenge 074 task 2 """


# ===============================================================================
#
#        FILE: ch-_.py
#
#        USAGE: ./ch_2.py
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/
#
#               TASK #2 › FNR Character
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 08/22/2020 12:40:09 PM
# ===============================================================================


def get_fnr(in_str):
    """ Find and return the FNR in the given string """

    fnr_count = dict()
    fnr_queue = list()

    result = ''

    for char in in_str:
        fnr_count[char] = fnr_count.get(char, 0) + 1

        if fnr_count[char] == 1:
            fnr_queue.append(char)
        else:
            fnr_queue.remove(char)

        result += fnr_queue[-1] if fnr_queue else '#'

    return result


assert get_fnr('ababc') == 'abb#c'
assert get_fnr('xyzzyx') == 'xyzyx#'

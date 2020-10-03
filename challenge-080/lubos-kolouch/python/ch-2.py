#!/bin/env pythoon
"""
#===============================================================================
#
#         FILE: ch_2.py
#
#        USAGE: ./ch_2.py
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/
#               Challenge #2
#               Count Candies
#
#       AUTHOR: Lubos Kolouch
#===============================================================================
"""


def get_candle_count(arr: list):
    """ Count the candles """

    # We need to give 1 candy to everyone
    count = len(arr)

    # and then find out number of unique elements as they will be certainly
    # bigger than neighbor... -1 (the initial poor one)

    count += len(set(arr))
    count -= 1

    return count


assert get_candle_count([1, 2, 2]) == 4
assert get_candle_count([1, 4, 3, 2]) == 7

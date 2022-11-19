#!/usr/bin/env python3

"""
Week 191:
    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

    Task 1: Twice Largest You are given list of integers, @list. Write a script to find out whether the largest item in
    the list is at least twice as large as each of the other items.
"""


def doesTwiceLargestNumberExists(number_list):
    number_list.sort()

    return 1 if number_list[-1] >= number_list[-2] ** 2 else -1


def testDoesTwiceLargestNumberExists():
    assert doesTwiceLargestNumberExists([1, 2, 3, 4]) == -1, 'Example 1 Failed'
    assert doesTwiceLargestNumberExists([1, 2, 0, 5]) == 1, 'Example 2 Failed'
    assert doesTwiceLargestNumberExists([2, 6, 3, 1]) == 1, 'Example 3 Failed'
    assert doesTwiceLargestNumberExists([4, 5, 2, 3]) == -1, 'Example 4 Failed'

    return


testDoesTwiceLargestNumberExists()

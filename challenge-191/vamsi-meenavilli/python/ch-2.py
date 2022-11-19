#!/usr/bin/env python3

"""
Week 191:
    https://theweeklychallenge.org/blog/perl-weekly-challenge-192

    Task 2: Cute List You are given an integer, 0 < $n <= 15. Write a script to find the number of orderings of
    numbers that form a cute list. With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of
    @list is cute if for every entry, indexed with a base of 1, either
"""


def getCuteListCount(number):
    cute_list_count = 0
    numbers_list = [i for i in range(1, number + 1)]

    for i in range(number):
        numbers_sub_list = numbers_list[i + 1:] + numbers_list[:i]

        for j in range(number - 1):
            if isCuteList([numbers_list[i]] + numbers_sub_list[j:] + numbers_sub_list[:j]):
                cute_list_count += 1

    return cute_list_count


def isCuteList(number_list):
    for index, number in enumerate(number_list, 1):
        if not (number % index == 0 or index % number == 0):
            return 0

    return 1


def testGetCuteListCount():
    assert getCuteListCount(2) == 2, 'Example 1 Failed'

    return


testGetCuteListCount()

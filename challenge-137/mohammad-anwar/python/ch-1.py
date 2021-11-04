#!/usr/bin/python3

'''

Week 137:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-137

Task #1: Long Year

    Write a script to find all the years between 1900 and 2100 which is a Long Year.

'''

import sys
import datetime
import unittest
import collections

def is_leap(year):
    leap = False

    if year%400 == 0:
        leap = True
    elif year%4 == 0 and year%100 != 0:
        leap = True

    return leap

def week_number(year, month, day):
    return datetime.date(year, month, day).isocalendar()[1]

def week_day(year, month, day):
    return datetime.date(year, month, day).weekday()

def long_year(year):
    if week_number(year, 12, 31) == 53:
        if is_leap(year):
            if week_day(year, 1, 1) == 2 or week_day(year, 12, 31) == 4:
                return True
        elif week_day(year, 1, 1) == 3 or week_day(year, 12, 31) == 3:
            return True

    return False

def task_example():
    exp = [
        1903, 1908, 1914, 1920, 1925,
        1931, 1936, 1942, 1948, 1953,
        1959, 1964, 1970, 1976, 1981,
        1987, 1992, 1998, 2004, 2009,
        2015, 2020, 2026, 2032, 2037,
        2043, 2048, 2054, 2060, 2065,
        2071, 2076, 2082, 2088, 2093,
        2099,
    ]

    got = []
    for y in range(1900, 2100):
        if long_year(y):
            got.append(y)

    if collections.Counter(exp) == collections.Counter(got):
        return True
    else:
        return False

#
#
# Unit test class

class TestLongYear(unittest.TestCase):

    def test_example(self):
        self.assertEqual(task_example(), 1, 'Task Example')

unittest.main()

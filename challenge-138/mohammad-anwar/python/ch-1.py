#!/usr/bin/python3

'''

Week 138:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-138

Task #1: Workdays

    You are given a year in 4-digits form. Write a script to calculate the total number of workdays in the given year.

'''

import unittest
from datetime import datetime
from datetime import timedelta

def workdays(year):
    d = 1
    m = 1
    y = year

    workdays = 0
    while year == y:

        date = datetime(y, m, d)
        if date.weekday() < 5: workdays += 1
        date = date + timedelta(days = 1)

        y = date.year
        m = date.month
        d = date.day

    return workdays

#
#
# Unit test class

class TestWorkdays(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(workdays(2021), 261, 'Example 1')

    def test_example_2(self):
        self.assertEqual(workdays(2020), 262, 'Example 2')

unittest.main()

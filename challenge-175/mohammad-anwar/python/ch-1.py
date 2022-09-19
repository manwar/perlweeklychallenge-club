#!/usr/bin/python3

'''

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #1: Last Sunday

    Write a script to list Last Sunday of every month in the given year.

'''

import unittest
from datetime import date, timedelta
from dateutil.relativedelta import relativedelta

def allLastSundayOf(year):
    ls = []
    for month in range(1, 13):
        ls.append(lastSundayOf(month, year))

    return ls

def lastSundayOf(month, year):
    d = date(year, month, 1) + relativedelta(months = 1) - timedelta(days = 1)
    dow = d.isoweekday()

    if dow != 7:
        d = d - timedelta(days = dow)

    return d.isoformat()

#
#
# Unit test class

class TestLastSunday(unittest.TestCase):
    def test_example(self):
        exp = [
            "2022-01-30", "2022-02-27", "2022-03-27", "2022-04-24",
            "2022-05-29", "2022-06-26", "2022-07-31", "2022-08-28",
            "2022-09-25", "2022-10-30", "2022-11-27", "2022-12-25",
        ]
        got = allLastSundayOf(2022)
        self.assertEqual(exp, got)

unittest.main()

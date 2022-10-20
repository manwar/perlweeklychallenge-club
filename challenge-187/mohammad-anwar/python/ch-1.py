#!/usr/bin/python3

'''

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #1: Days Together

    Two friends, Foo and Bar gone on holidays seperately to the same
    city. You are given their schedule i.e. start date and end date.

    To keep the task simple, the date is in the form 'DD-MM' and all
    dates belong to the  same calendar year i.e. between '01-01' and
    '31-12'.

    Also the year is non-leap year and both dates are inclusive.

'''

import unittest
from datetime import date, timedelta

def _date(dateStr) -> date:
    (day, month) = dateStr.split("-")
    return date(2022, int(month), int(day))

def _days_together(fromDate, toDate, _toDate) -> int:
    if _toDate is not None:
        if toDate > _toDate:
            toDate = _toDate

    delta = toDate - fromDate
    return delta.days + 1

def daysTogether(sd1, ed1, sd2, ed2) -> int:
    _sd1 = _date(sd1)
    _ed1 = _date(ed1)
    _sd2 = _date(sd2)
    _ed2 = _date(ed2)

    days = 0

    if _ed1 < _sd2:
        return days

    if _ed1 <= _sd2:
        days = _days_together(_ed1, _ed2)
    elif _sd2 <= _sd1:
        days = _days_together(_sd1, _ed1, _ed2)
    elif _sd2 <= _ed2:
        days = _days_together(_sd2, _ed1, _ed2)

    return days

#
#
# Unit test class

class TestDaysTogether(unittest.TestCase):
    def test_daysTogether(self):
        self.assertEqual(daysTogether('12-01','20-01','15-01','18-01'), 4)
        self.assertEqual(daysTogether('02-03','12-03','13-03','14-03'), 0)
        self.assertEqual(daysTogether('02-03','12-03','11-03','15-03'), 2)
        self.assertEqual(daysTogether('30-03','05-04','28-03','02-04'), 4)

unittest.main()

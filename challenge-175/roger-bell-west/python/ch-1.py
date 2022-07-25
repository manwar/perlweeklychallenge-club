#! /usr/bin/python3

import unittest

from datetime import date,timedelta

def lastsunday(year0):
  year = year0
  o = []
  day = timedelta(days = 1)
  for month0 in range(2,14):
    month = month0
    if month0 == 13:
      year += 1
      month -= 12
    dt = date(year,month,1) - day
    dl = dt.weekday()
    if dl < 6:
      dt -= (1 + dl) * day
    o.append(dt.strftime("%Y-%m-%d"))
  return o

class TestLastSunday(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(lastsunday(2022),
                           [
                             '2022-01-30',
                             '2022-02-27',
                             '2022-03-27',
                             '2022-04-24',
                             '2022-05-29',
                             '2022-06-26',
                             '2022-07-31',
                             '2022-08-28',
                             '2022-09-25',
                             '2022-10-30',
                             '2022-11-27',
                             '2022-12-25'
                           ],
                           'example 1')
 
unittest.main()

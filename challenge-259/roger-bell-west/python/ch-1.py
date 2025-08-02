#! /usr/bin/python3

from datetime import date, timedelta

def bankingdayoffset(start, offset, bankholidays):
  bh = set(date.fromisoformat(i) for i in bankholidays)
  d = date.fromisoformat(start)
  day = timedelta(days = 1)
  for _ in range(offset):
    d += day
    while d in bh or d.weekday() > 4:
      d += day
  return d.strftime("%Y-%m-%d")

import unittest

class TestBankingdayoffset(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(bankingdayoffset("2018-06-28", 3, ["2018-07-03"]), "2018-07-04", 'example 1')

  def test_ex2(self):
    self.assertEqual(bankingdayoffset("2018-06-28", 3, []), "2018-07-03", 'example 2')

unittest.main()

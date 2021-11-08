#! /usr/bin/python3

import unittest

from datetime import date,timedelta

def mirdat(then,now):
  if now[0]==0:
    nowt=date.today()
  else:
    nowt=date(*now)
  thent=date(*then)
  delta=nowt-thent
  o=[]
  for targett in [thent-delta,nowt+delta]:
    o.append([targett.year,targett.month,targett.day])
  return o

class TestMirdat(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(mirdat([2021,9,18],[2021,9,22]),[[2021,9,14],[2021,9,26]],'example 1')

        def test_ex2(self):
          self.assertEqual(mirdat([1975,10,10],[2021,9,22]),[[1929,10,27],[2067,9,5]],'example 2')

        def test_ex3(self):
          self.assertEqual(mirdat([1967,2,14],[2021,9,22]),[[1912,7,8],[2076,4,30]],'example 3')

unittest.main()

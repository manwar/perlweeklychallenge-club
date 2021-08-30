#! /usr/bin/python3

import unittest

from collections import defaultdict

def mp(aa,da):
  e=defaultdict(lambda: 0)
  for p in [[aa,1],[da,-1]]:
    for tm in p[0]:
      hm=tm.split(":")
      e[int(hm[0])*60+int(hm[1])] += p[1]
  pt=0
  pm=0
  for ts in sorted(e.keys()):
    pt+=e[ts]
    if pt > pm:
      pm=pt
  return pm

class TestMp(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(mp(["11:20","14:30"],["11:50","15:00"]),1,'example 1')

        def test_ex2(self):
          self.assertEqual(mp(["10:20","11:00","11:10","12:20","16:20","19:00"],["10:30","13:20","12:40","12:50","20:20","21:20"]),3,'example 2')
          
unittest.main()

#! /usr/bin/python3

import unittest

def p(y):
  return (y+int(y/4)-int(y/100)+int(y/400)) % 7

def leapyear(y):
  return y%4==0 and (y%100!=0 or y%400==0)

def workdays(y):
  i=p(y)
  if leapyear(y):
    i+=7
  return 260+[0,1,1,1,1,0,0,1,2,2,2,2,1][i]

class TestWorkdays(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(workdays(2021),260,'example 1')

        def test_ex2(self):
          self.assertEqual(workdays(2020),262,'example 2')

unittest.main()

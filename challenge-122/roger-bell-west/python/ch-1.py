#! /usr/bin/python3

import unittest
import re

def aos(m):
  n=0
  t=0
  o=list()
  for i in m:
    t+=i
    n+=1
    o.append(t/n)
  return o

class TestAos(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(aos([10, 20, 30, 40, 50, 60, 70, 80, 90]),[10, 15, 20, 25, 30, 35, 40, 45, 50],'example 1')
          
unittest.main()

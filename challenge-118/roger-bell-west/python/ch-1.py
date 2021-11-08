#! /usr/bin/python3

import unittest
import re

def bp(n):
  s="{0:b}".format(n)
  l=len(s)-1;
  for i in range(int(l/2)+1):
    if s[i] != s[l-i]:
      return 0
  return 1

class TestBp(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(bp(5),1,'example 1')
          
        def test_ex2(self):
          self.assertEqual(bp(4),0,'example 2')

unittest.main()

#! /usr/bin/python3

import unittest
import re

def sw(c):
  n=0
  p=re.compile(r".*([04-9]|11).*")
  while (c>0):
    n+=1
    if p.match(str(n)):
      continue;
    c-=1
  return n

class TestSw(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sw(5),13,'example 1')
          
        def test_ex2(self):
          self.assertEqual(sw(10),32,'example 2')

        def test_ex3(self):
          self.assertEqual(sw(60),2223,'example 2')

unittest.main()

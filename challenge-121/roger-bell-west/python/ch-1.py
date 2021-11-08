#! /usr/bin/python3

import unittest
import re

def ib(m,n):
  return m ^ (1 << (n-1))

class TestIb(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(ib(12,3),8,'example 1')
          
        def test_ex2(self):
          self.assertEqual(ib(18,4),26,'example 2')

unittest.main()

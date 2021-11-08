#! /usr/bin/python3

import unittest
import re

def sn(n):
  t=divmod(n,16)
  return 16*t[1]+t[0]

class TestSn(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sn(101),86,'example 1')
          
        def test_ex2(self):
          self.assertEqual(sn(18),33,'example 2')

unittest.main()

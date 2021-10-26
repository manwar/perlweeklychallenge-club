#! /usr/bin/python3

import unittest

from math import gcd

def ispower2(n):
  if n<2:
    return False
  return (n & (n-1))==0

def twofriendly(m,n):
  return 1 if ispower2(gcd(m,n)) else 0

class TestTwofriendly(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(twofriendly(8,24),1,'example 1')

        def test_ex2(self):
          self.assertEqual(twofriendly(26,39),0,'example 2')

        def test_ex3(self):
          self.assertEqual(twofriendly(4,10),1,'example 3')

        def test_ex4(self):
          self.assertEqual(twofriendly(1,2),0,'example 4')

unittest.main()

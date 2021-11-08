#! /usr/bin/python3

import unittest

def lychrel(nn):
  n=nn
  for _ in range(100):
    m=int(str(n)[::-1])
    if m==n:
      return 0
    n+=m
    if n>1e7:
      break
  return -1

class TestLychrel(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(lychrel(56),0,'example 1')

        def test_ex2(self):
          self.assertEqual(lychrel(57),0,'example 2')

        def test_ex3(self):
          self.assertEqual(lychrel(58),0,'example 3')

        def test_ex4(self):
          self.assertEqual(lychrel(196),-1,'example 4')

unittest.main()

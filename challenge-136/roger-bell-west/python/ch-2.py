#! /usr/bin/python3

import unittest

def fibseq(m):
  return f(m,1,1)

def f(x,y,z):
  if x<y:
    return 1 if x==0 else 0
  else:
    return f(x-y,y+z,y)+f(x,y+z,y)

class TestFibseq(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fibseq(16),4,'example 1')

        def test_ex2(self):
          self.assertEqual(fibseq(9),2,'example 2')

        def test_ex3(self):
          self.assertEqual(fibseq(15),2,'example 3')

unittest.main()

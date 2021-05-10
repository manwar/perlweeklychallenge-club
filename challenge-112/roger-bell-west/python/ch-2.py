#! /usr/bin/python3

import unittest

def cs(i):
  a=0
  b=1
  c=0
  for x in range(i):
    c=a+b
    a=b
    b=c
  return c

class TestCs(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(cs(3),3,'example 1')
          
        def test_ex2(self):
          self.assertEqual(cs(4),5,'example 2')
          
        def test_ex3(self):
          self.assertEqual(cs(20),10946,'example 3')

unittest.main()

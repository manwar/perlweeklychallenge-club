#! /usr/bin/python3

import unittest

def mtable(i,j,k):
  l=[]
  for ix in range(1,i+1):
    for jx in range(1,j+1):
      l.append(ix*jx)
  l.sort()
  return l[k-1]

class TestMtable(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(mtable(2,3,4),3,'example 1')

        def test_ex2(self):
          self.assertEqual(mtable(3,3,6),4,'example 2')

unittest.main()

#! /usr/bin/python3

import unittest

from math import degrees,atan2

def rd(tree,content):
  depth=0
  dl=1
  db=1
  for i in range(len(tree)):
    if tree[i]==content:
      return depth
    dl -= 1
    if dl==0:
      db *= 2
      dl=db
      depth += 1
  return -1

class TestRd(unittest.TestCase):

        def test_ex1a(self):
          self.assertEqual(rd([
            1,
            2,      3,
            0,  0,  0,  4,
            0,0,0,0,0,0,5,6
          ],6),3,'example 1a')

        def test_ex1b(self):
          self.assertEqual(rd([
            1,
            2,      3,
            0,  0,  0,  4,
            0,0,0,0,0,0,5,6
          ],5),3,'example 1b')

        def test_ex1c(self):
          self.assertEqual(rd([
            1,
            2,      3,
            0,  0,  0,  4,
            0,0,0,0,0,0,5,6
          ],2),1,'example 1c')
          
        def test_ex1d(self):
          self.assertEqual(rd([
            1,
            2,      3,
            0,  0,  0,  4,
            0,0,0,0,0,0,5,6
          ],4),2,'example 1d')
          
        def test_ex2a(self):
          self.assertEqual(rd([
            1,
            2,              3,
            4,      0,      0,      5,
            0,  6,  0,  0,  0,  0,  7,  0,
            0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
          ],7),3,'example 2a')
          
        def test_ex2b(self):
          self.assertEqual(rd([
            1,
            2,              3,
            4,      0,      0,      5,
            0,  6,  0,  0,  0,  0,  7,  0,
            0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
          ],8),4,'example 2b')
          
        def test_ex2c(self):
          self.assertEqual(rd([
            1,
            2,              3,
            4,      0,      0,      5,
            0,  6,  0,  0,  0,  0,  7,  0,
            0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
          ],6),3,'example 2c')

unittest.main()

#! /usr/bin/python

import unittest

def leftrot(a,b):
  l=len(a)
  t=list()
  map(t.append,a)
  map(t.append,a)
  o=list()
  for c in (b):
    o.append(list((t[c:c+l])))
  return o

class TestLeftrot(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(leftrot((10, 20, 30, 40, 50),(3, 4)),
                         [[40, 50, 10, 20, 30],
                          [50, 10, 20, 30, 40]],
                         'example 1')

    def test_ex2(self):
        self.assertEqual(leftrot((7, 4, 2, 6, 3),(1, 3, 4)),
                         [[4, 2, 6, 3, 7],
                          [6, 3, 7, 4, 2],
                          [3, 7, 4, 2, 6]],
                         'example 2')

unittest.main()

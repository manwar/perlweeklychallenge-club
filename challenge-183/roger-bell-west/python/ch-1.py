#! /usr/bin/python3

import unittest

def uniquearray(n):
  o = []
  oh = set()
  for i in n:
    ti = tuple(i)
    if ti not in oh:
      o.append(i)
      oh.add(ti)
  return o

class TestUniquearray(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(uniquearray([[1,2], [3,4], [5,6], [1,2]]),
                           [[1,2], [3,4], [5,6]],
                           'example 1')

        def test_ex2(self):
          self.assertEqual(uniquearray([[9,1], [3,7], [2,5], [2,5]]),
                           [[9,1], [3,7], [2,5]],
                           'example 1')

unittest.main()

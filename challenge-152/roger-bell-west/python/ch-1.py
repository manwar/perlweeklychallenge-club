#! /usr/bin/python3

import unittest

def tsp(tree):
  mp=0
  for r in tree:
    mp += min(r)
  return mp

class TestTsp(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(tsp([[1],[5,3],[2,3,4],[7,1,0,2],[6,4,5,2,8]]),8,'example 1')

        def test_ex2(self):
          self.assertEqual(tsp([[5],[2,3],[4,1,4],[0,1,2,3],[7,2,4,1,9]]),9,'example 2')

unittest.main()

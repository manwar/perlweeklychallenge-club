#! /usr/bin/python3

import unittest

def on(list):
  k=dict()
  for n in list:
    if n in k:
      del k[n]
    else:
      k[n]=1
  return [*k][0]

class TestOn(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(on([2,5,4,4,5,5,2]),5,'example 1')

        def test_ex2(self):
          self.assertEqual(on([1,2,3,4,3,2,1,4,4]),4,'example 2')

unittest.main()

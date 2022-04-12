#! /usr/bin/python3

import unittest

from math import gcd
from functools import reduce

def lcm(m,n):
  return m//gcd(m,n)*n

def lcmseries(s):
  return reduce(lcm, s)

def farey(n):
  l=lcmseries(range(2,n+1))
  d=dict()
  s=[]
  for i in range(1,n+1):
    m=l // i
    for j in range(0,i+1):
      k=m*j
      if not k in d:
        d[k]=[j,i]
        s.append(k)
  s.sort()
  return [d[i] for i in s]

class TestFarey(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(farey(5),
                           [[0,1], [1,5], [1,4], [1,3], [2,5], [1,2],
                            [3,5], [2,3], [3,4], [4,5], [1,1]],
                           'example 1')

        def test_ex2(self):
          self.assertEqual(farey(7),
                           [[0,1], [1,7], [1,6], [1,5], [1,4], [2,7],
                            [1,3], [2,5], [3,7], [1,2], [4,7], [3,5],
                            [2,3], [5,7], [3,4], [4,5], [5,6], [6,7],
                            [1,1]],
                           'example 2')

        def test_ex3(self):
          self.assertEqual(farey(4),
                           [[0,1], [1,4], [1,3], [1,2], [2,3], [3,4],
                            [1,1]],
                           'example 3')

unittest.main()

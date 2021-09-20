#! /usr/bin/python3

import unittest

def csa(lst):
  o=[[lst[0]]]
  i=iter(lst)
  next(i)
  for n in i:
    if o[-1][-1]+1 != n:
      o.append([])
    o[-1].append(n)
  return o

class TestCsa(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(csa([1,2,3,6,7,8,9]),[[1,2,3],[6,7,8,9]],'example 1')

        def test_ex2(self):
          self.assertEqual(csa([11,12,14,17,18,19]),[[11,12],[14],[17,18,19]],'example 2')

        def test_ex3(self):
          self.assertEqual(csa([2,4,6,8]),[[2],[4],[6],[8]],'example 3')

        def test_ex4(self):
          self.assertEqual(csa([1,2,3,4,5]),[[1,2,3,4,5]],'example 4')

unittest.main()

#! /usr/bin/python3

import unittest

def kronecker(a,b):
  o = []
  ax = len(a[0])
  ay = len(a)
  bx = len(b[0])
  by = len(b)
  for y in range(ay * by):
    byi = y % by
    ayi = y // by
    row = []
    for x in range(ax * bx):
      bxi = x % bx
      axi = x // bx
      row.append(a[ayi][axi] * b[byi][bxi])
    o.append(row)
  return o

class TestKronecker(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(kronecker([[1,2],[3,4]],
                                     [[5,6],[7,8]]),
                           [[ 5,  6, 10, 12],
                            [ 7,  8, 14, 16],
                            [15, 18, 20, 24],
                            [21, 24, 28, 32]],'example 1')

unittest.main()

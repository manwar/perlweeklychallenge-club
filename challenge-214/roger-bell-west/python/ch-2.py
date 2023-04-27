#! /usr/bin/python3

from copy import deepcopy

def collectpoints(a):
  m = []
  st = 0
  while st < len(a):
    k = a[st]
    e = st
    while e < len(a) and a[e] == k:
      e += 1
    m.append([k, e - st])
    st = e
  rv = 0
  stack = [[m, 0]]
  while len(stack) > 0:
    s = stack.pop()
    if len(s[0]) == 0:
      rv = max(rv, s[1])
    else:
      for i in range(len(s[0])):
        ss = deepcopy(s)
        ss[1] += ss[0][i][1] * ss[0][i][1]
        del ss[0][i]
        j = i
        while True:
          if j > 0 and j < len(ss[0]) and ss[0][j][0] == ss[0][j - 1][0]:
            ss[0][j][1] += ss[0][j - 1][1]
            del ss[0][j - 1]
            j -= 1
          else:
            break
        stack.append(ss)
  return rv

import unittest

class TestCollectpoints(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(collectpoints([2, 4, 3, 3, 3, 4, 5, 4, 2]), 23, 'example 1')

  def test_ex2(self):
    self.assertEqual(collectpoints([1, 2, 2, 2, 2, 1]), 20, 'example 2')

  def test_ex3(self):
    self.assertEqual(collectpoints([1]), 1, 'example 3')

  def test_ex4(self):
    self.assertEqual(collectpoints([2, 2, 2, 1, 1, 2, 2, 2]), 40, 'example 4')

unittest.main()

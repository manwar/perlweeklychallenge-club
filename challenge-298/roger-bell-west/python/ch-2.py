#! /usr/bin/python3

def rightinterval(a):
  ss  = [x[0] for x in a]
  si = list(range(len(a)))
  si.sort(key = lambda i: ss[i])
  out = []
  for l in a:
    ix = [i for i in si if ss[i] >= l[1]]
    if len(ix) == 0:
      out.append(-1)
    else:
      out.append(ix[0])
  return out

import unittest

class TestRightinterval(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(rightinterval([[3, 4], [2, 3], [1, 2]]), [-1, 0, 1], 'example 1')

  def test_ex2(self):
    self.assertEqual(rightinterval([[1, 4], [2, 3], [3, 4]]), [-1, 2, -1], 'example 2')

  def test_ex3(self):
    self.assertEqual(rightinterval([[1, 2]]), [-1], 'example 3')

  def test_ex4(self):
    self.assertEqual(rightinterval([[1, 4], [2, 2], [3, 4]]), [-1, 1, -1], 'example 4')

unittest.main()

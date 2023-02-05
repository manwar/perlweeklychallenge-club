#! /usr/bin/python3

import unittest

def widestvalley(a):
  av = []
  ac = []
  l = -1
  for v in a:
    if v == l:
      ac[-1] += 1
    else:
      av.append(v)
      ac.append(1)
      l = v
  s = []
  e = []
  c = 0
  for i in range(len(av)):
    if i ==0 or i == len(av) - 1 or (av[i - 1] < av[i] and av[i] > av[i + 1]):
      s.append(c)
      e.append(c + ac[i] - 1)
    c += ac[i]
  out = []
  for i in range(len(s) - 1):
    if e[i+1] - s[i] + 1 > len(out):
      out = a[s[i] : e[i+1] + 1];
  return out


class TestWidestvalley(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(widestvalley([1, 5, 5, 2, 8]), [5, 5, 2, 8], 'example 1')

  def test_ex2(self):
    self.assertEqual(widestvalley([2, 6, 8, 5]), [2, 6, 8], 'example 2')

  def test_ex3(self):
    self.assertEqual(widestvalley([9, 8, 13, 13, 2, 2, 15, 17]), [13, 13, 2, 2, 15, 17], 'example 3')

  def test_ex4(self):
    self.assertEqual(widestvalley([2, 1, 2, 1, 3]), [2, 1, 2], 'example 4')

  def test_ex5(self):
    self.assertEqual(widestvalley([1, 3, 3, 2, 1, 2, 3, 3, 2]), [3, 3, 2, 1, 2, 3, 3], 'example 5')

unittest.main()

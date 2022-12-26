#! /usr/bin/python3

import unittest

def is_wigglesorted(l):
  for i in range(len(l) - 1):
    if i % 2 == 0:
      if l[i] >= l[i+1]:
        return False
    else:
      if l[i] <= l[i+1]:
        return False
  return True

def wigglesort(l):
  s = l
  s.sort()
  le = len(s)
  p = le // 2
  a = s[0 : p]
  b = s[p : le]
  i = 0
  o = []
  if le % 2 == 1:
    o.append(s[p])
    b = s[p + 1 : le]
    i = 1
  for j in range(i, le):
    if j % 2 == 0:
      o.append(a.pop())
    else:
      o.append(b.pop())
  return o

class TestRangelist(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(is_wigglesorted([1,5,1,1,6,4]), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(is_wigglesorted([1,6,1,5,1,4]), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(is_wigglesorted([1,3,2,2,3,1]), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(is_wigglesorted([2,3,1,3,1,2]), 1, 'example 4')

  def test_ex5(self):
    self.assertEqual(is_wigglesorted([1,3,2,2,3,1]), 0, 'example 5')
        
  def test_ex6(self):
    self.assertEqual(is_wigglesorted(wigglesort([1,5,1,1,6,4])), 1, 'example 6')

  def test_ex7(self):
    self.assertEqual(is_wigglesorted(wigglesort([1,3,2,2,3,1])), 1, 'example 7')

  def test_ex8(self):
    self.assertEqual(is_wigglesorted(wigglesort([1,3,2,2,2,3,1])), 1, 'example 8')

unittest.main()

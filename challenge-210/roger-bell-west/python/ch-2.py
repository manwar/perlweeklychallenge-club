#! /usr/bin/python3

import unittest

def numbercollision(aa):
  a = aa
  dirty = True
  while dirty:
    b = []
    dirty = False
    i = 0
    while i + 1 <= len(a):
      if i + 1 < len(a) and a[i] > 0 and a[i + 1] < 0:
        ab = abs(a[i + 1])
        if a[i] > ab:
          b.append(a[i])
        elif a[i] < ab:
          b.append(a[i + 1])
        i += 2
        dirty = True
      else:
        b.append(a[i])
        i += 1
    a = b
  return a

class TestNumbercollision(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(numbercollision([2, 3, -1]), [2, 3], 'example 1')

  def test_ex2(self):
    self.assertEqual(numbercollision([3, 2, -4]), [-4], 'example 2')

  def test_ex3(self):
    self.assertEqual(numbercollision([1, -1]), [], 'example 3')

unittest.main()

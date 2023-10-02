#! /usr/bin/python3

import unittest

def boxcoins(ints):
  mx = 0
  stack = [ ( ints, 0 ) ]
  while len(stack) > 0:
    t, tot = stack.pop()
    if tot > mx:
      mx = tot
    for i in range(len(t)):
      p = t[i]
      if i > 0:
        p *= t[i - 1]
      if i < len(t) - 1:
        p *= t[i + 1]
      stot = tot + p
      tt = [t[ix] for ix in range(len(t)) if i != ix]
      stack.append((tt, stot))
  return mx      

class TestBoxcoins(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(boxcoins([3, 1, 5, 8]), 167, 'example 1')

  def test_ex2(self):
    self.assertEqual(boxcoins([1, 5]), 10, 'example 2')

unittest.main()

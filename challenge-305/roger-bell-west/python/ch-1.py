#! /usr/bin/python3

def isqrt(s:int):
  if s <= 1:
    return s
  x0 = s // 2
  x1 = (x0 + s // x0) // 2
  while x1 < x0:
    x0 = x1
    x1 = (x0 + s // x0) // 2
  return x0

def is_prime(candidate):
  if candidate < 2:
    return False
  elif candidate==2:
    return True
  elif candidate==3:
    return True
  elif candidate % 2 == 0:
    return False
  elif candidate % 3 == 0:
    return False
  anchor = 0
  limit = isqrt(candidate)
  while True:
    anchor += 6
    for t in range(anchor-1,anchor+2,2):
      if t > limit:
        return True
      if candidate % t == 0:
        return False

def binaryprefix(a):
  out = []
  n = 0
  for x in a:
    n *= 2
    if x == 1:
      n += 1
    out.append(is_prime(n))
  return out

import unittest

class TestBinaryprefix(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(binaryprefix([1, 0, 1]), [False, True, True], 'example 1')

  def test_ex2(self):
    self.assertEqual(binaryprefix([1, 1, 0]), [False, True, False], 'example 2')

  def test_ex3(self):
    self.assertEqual(binaryprefix([1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]), [False, True, True, False, False, True, False, False, False, False, False, False, False, False, False, False, False, False, False, True], 'example 3')

unittest.main()

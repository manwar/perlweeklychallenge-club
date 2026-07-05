#! /usr/bin/python3

from collections import defaultdict

def counterify(a):
  s = defaultdict(lambda: 0)
  for n in a:
    s[n] += 1
  return s

def sumoffrequencies(a):
  vw = 0
  cn = 0
  cc = counterify(a)
  cv = list(cc.values())
  cv.sort()
  cv.reverse()
  for n in cv:
    for c, ni in cc.items():
      if ni == n:
        match c:
          case 'a' | 'e' | 'i' | 'o' | 'u':
            if vw == 0:
              vw = n
          case _:
            if cn == 0:
              cn = n
        if vw > 0 and cn > 0:
          break
    if vw > 0 and cn > 0:
      break
  return vw + cn
import unittest

class TestSumoffrequencies(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(sumoffrequencies("banana"), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(sumoffrequencies("teestett"), 7, 'example 2')

  def test_ex3(self):
    self.assertEqual(sumoffrequencies("aeiouuaa"), 3, 'example 3')

  def test_ex4(self):
    self.assertEqual(sumoffrequencies("rhythm"), 2, 'example 4')

  def test_ex5(self):
    self.assertEqual(sumoffrequencies("x"), 1, 'example 5')

unittest.main()

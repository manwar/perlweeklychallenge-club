#! /usr/bin/python3

from collections import defaultdict

def counterify(a):
  s = defaultdict(lambda: 0)
  for n in a:
    s[n] += 1
  return s

def countdigits(a):
  return counterify(str(a))

def shufflepairs(low, high, pairs):
  total = 0
  for candidate in range(low, high + 1):
    candidatec = countdigits(candidate)
    cnt = 0
    for mul in range(2, 10):
      test = candidate * mul
      testc = countdigits(test)
      if testc == candidatec:
        cnt += 1
        if cnt >= pairs:
          break
    if cnt >= pairs:
      total += 1
  return total

import unittest

class TestShufflepairs(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(shufflepairs(1, 1000, 1), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(shufflepairs(1500, 2500, 1), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(shufflepairs(1000000, 1500000, 5), 2, 'example 3')

  def test_ex4(self):
    self.assertEqual(shufflepairs(13427000, 14100000, 2), 11, 'example 4')

  def test_ex5(self):
    self.assertEqual(shufflepairs(1000, 5000, 1), 7, 'example 5')

unittest.main()

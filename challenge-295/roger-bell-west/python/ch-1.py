#! /usr/bin/python3

from collections import deque

def wordbreak(a, words):
  queue = deque()
  queue.append(a)
  while len(queue) > 0:
    remnant = queue.popleft()
    if len(remnant) == 0:
      return True
    for candidate in words:
      if remnant.find(candidate) == 0:
        queue.append(remnant.removeprefix(candidate))
  return False

import unittest

class TestWordbreak(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(wordbreak("weeklychallenge", ["challenge", "weekly"]), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(wordbreak("perlrakuperl", ["raku", "perl"]), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(wordbreak("sonsanddaughters", ["sons", "sand", "daughters"]), False, 'example 3')

unittest.main()

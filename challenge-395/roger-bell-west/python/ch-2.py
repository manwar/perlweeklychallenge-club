#! /usr/bin/python3

from collections import deque

def wordsquares(a):
  l = len(a[0])
  words = set(a)
  queue = deque()
  for w in a:
    queue.append([w])
  while len(queue) > 0:
    p = queue.popleft()
    if len(p) == l:
      return p
    for ca in words - set(p):
      valid = True
      for i, c in enumerate(ca):
        if i >= len(p):
          break
        if c != p[i][len(p)]:
          valid = False
          break
      if valid:
        pw = p.copy()
        pw.append(ca)
        queue.append(pw)
  return []
  
import unittest

class TestWordsquares(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(wordsquares(["MA", "AM", "MY", "ME"]), ["MA", "AM"], 'example 1')

  def test_ex2(self):
    self.assertEqual(wordsquares(["SUN", "USE", "NET", "SEE", "TEN"]), ["SUN", "USE", "NET"], 'example 2')

  def test_ex3(self):
    self.assertEqual(wordsquares(["BOAT", "TEAL", "AREA", "TSAR", "OGRE"]), ["BOAT", "OGRE", "AREA", "TEAL"], 'example 3')

  def test_ex4(self):
    self.assertEqual(wordsquares(["CARD", "AREA", "REAR", "DART"]), ["CARD", "AREA", "REAR", "DART"], 'example 4')

  def test_ex5(self):
    self.assertEqual(wordsquares(["HEART", "TREND", "EMBER", "RESIN", "ABUSE"]), ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"], 'example 5')

unittest.main()

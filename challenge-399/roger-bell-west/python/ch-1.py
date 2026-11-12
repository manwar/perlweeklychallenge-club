#! /usr/bin/python3

from collections import deque

def lsub(wm, t):
  start = 0
  state = 0
  ll = []
  for n in range(len(wm)):
    if state == 0:
      if wm[n] == t:
        start = n
        state = 1
    else:
      if wm[n] != t:
        ll.append(n - start)
        state = 0
  if state == 1:
    ll.append(len(wm) - start)
  return max(ll)

def longestrepeatingcharacter(st, k):
  origin = list(st)
  targets = set(origin)
  longestsub = 0
  for t in targets:
    queue = deque()
    queue.append([origin, 0])
    while len(queue) > 0:
      wm, ct = queue.popleft()
      longestsub = max(longestsub, lsub(wm, t))
      if ct < k:
        ctp = ct + 1
        for n in range(len(wm)):
          if wm[n] != t:
            wmp = wm.copy()
            wmp[n] = t
            queue.append([wmp, ctp])
  return longestsub

import unittest

class TestLongestrepeatingcharacter(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(longestrepeatingcharacter("AAAAA", 2), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(longestrepeatingcharacter("ABCDE", 4), 5, 'example 2')

  def test_ex3(self):
    self.assertEqual(longestrepeatingcharacter("AAABBBBAA", 1), 5, 'example 3')

  def test_ex4(self):
    self.assertEqual(longestrepeatingcharacter("ABACADA", 2), 5, 'example 4')

  def test_ex5(self):
    self.assertEqual(longestrepeatingcharacter("BAAABAAAA", 1), 8, 'example 5')

unittest.main()

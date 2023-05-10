#! /usr/bin/python3

from collections import Counter, defaultdict, deque
from copy import deepcopy

def wordstickers(stickers, word):
  w = Counter()
  for c in word:
    w[c] += 1
  t = deepcopy(w)
  stick = []
  for s in stickers:
    f = Counter()
    for c in s.lower():
      f[c] += 1
      del t[c]
    stick.append(f)
  if len(t) != 0:
    return 0
  stack = deque()
  stack.append((w, 0))
  while len(stack) > 0:
    st = stack.popleft()
    if len(st[0]) == 0:
      return st[1]
    else:
      n = st[1] + 1
      for sti in stick:
        sp = deepcopy(st[0])
        v = False
        for l in sti.keys():
          if l in sp:
            v = True
            p = sp[l] - sti[l]
            if p > 0:
              sp[l] = p
            else:
              del sp[l]
        if v:
          stack.append((sp, n))

import unittest

class TestWordstickers(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(wordstickers(["perl", "raku", "python"], "peon"), 2, 'example 1')

  def test_ex2(self):
    self.assertEqual(wordstickers(["love", "hate", "angry"], "goat"), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(wordstickers(["come", "nation", "delta"], "accomodation"), 4, 'example 3')

  def test_ex4(self):
    self.assertEqual(wordstickers(["come", "country", "delta"], "accomodation"), 0, 'example 4')

unittest.main()

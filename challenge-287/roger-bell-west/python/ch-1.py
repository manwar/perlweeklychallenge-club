#! /usr/bin/python3

from collections import defaultdict

def strongpassword(a):
  ctypes = defaultdict(lambda: 0)
  reps = 0
  rep = 0
  old = '@'
  changes = []
  for i, c in enumerate(a):
      if i > 0 and c == old:
        rep += 1
        if rep >= 2:
          reps += 1
      else:
        rep = 0
        old = c
      t = 'n'
      if c.isupper():
        t = 'u'
      elif c.islower():
         t = 'l'
      elif c.isdigit():
        t = 'd'
        ctypes[t] += 1
  changes.append(reps)
  if 'n' in ctypes:
    del ctypes['n']
  k = len(ctypes.keys())
  if k < 3:
    spare = sum(ctypes.values()) - k
    if spare < 0:
      changes.append(-spare)
  if len(a) < 6:
    changes.append(6 - len(a))
  return max(changes)


import unittest

class TestStrongpassword(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(strongpassword("a"), 5, 'example 1')

  def test_ex2(self):
    self.assertEqual(strongpassword("aB2"), 3, 'example 2')

  def test_ex3(self):
    self.assertEqual(strongpassword("PaaSW0rd"), 0, 'example 3')

  def test_ex4(self):
    self.assertEqual(strongpassword("Paaasw0rd"), 1, 'example 4')

  def test_ex5(self):
    self.assertEqual(strongpassword("aaaaa"), 3, 'example 5')

unittest.main()

#! /usr/bin/python3

def brokenkeys(name, typed):
  ni = 0
  ti = 0
  while True:
    if name[ni] != typed[ti]:
      return False
    if ti == len(typed) - 1:
      break
    if ni < len(name) - 1 and name[ni + 1] == name[ni]:
      ni += 1
    else:
      while ti < len(typed) and typed[ti] == name[ni]:
        ti += 1
      if ti == len(typed):
        break
      ni += 1
  return True

import unittest

class TestBrokenkeys(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(brokenkeys("perl", "perrrl"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(brokenkeys("raku", "rrakuuuu"), True, 'example 2')

  def test_ex3(self):
    self.assertEqual(brokenkeys("python", "perl"), False, 'example 3')

  def test_ex4(self):
    self.assertEqual(brokenkeys("coffeescript", "cofffeescccript"), True, 'example 4')

unittest.main()

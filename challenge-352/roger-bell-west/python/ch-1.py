#! /usr/bin/python3

def matchstring(a):
  out = []
  for x in a:
    if x not in out:
      for y in a:
        if len(y) > len(x) and y.find(x) > -1:
          out.append(x)
          break
  return out

import unittest

class TestMatchstring(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(matchstring(["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"]), ["cat", "dog", "dogcat", "rat"], 'example 1')

  def test_ex2(self):
    self.assertEqual(matchstring(["hello", "hell", "world", "wor", "ellow", "elloworld"]), ["hell", "world", "wor", "ellow"], 'example 2')

  def test_ex3(self):
    self.assertEqual(matchstring(["a", "aa", "aaa", "aaaa"]), ["a", "aa", "aaa"], 'example 3')

  def test_ex4(self):
    self.assertEqual(matchstring(["flower", "flow", "flight", "fl", "fli", "ig", "ght"]), ["flow", "fl", "fli", "ig", "ght"], 'example 4')

  def test_ex5(self):
    self.assertEqual(matchstring(["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"]), ["car", "pet", "enter", "pen", "pent"], 'example 5')

unittest.main()

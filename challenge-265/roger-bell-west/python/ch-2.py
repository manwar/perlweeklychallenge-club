#! /usr/bin/python3

from collections import defaultdict

def str2hash(a):
  m = defaultdict(lambda: 0)
  for c in a:
    if c.isalpha():
      m[c.lower()] += 1
  return m

def completingword(a, cw):
  ah = str2hash(a)
  out = []
  for t in cw:
    valid = True
    th = str2hash(t)
    for k, v in ah.items():
      if k not in th:
        valid = False
        break
      if th[k] < v:
        valid = False
        break
    if valid:
      out.append(t)
  if len(out) == 0:
    return ""
  out.sort(key = lambda i: len(i))
  return out[0]
            
import unittest

class TestCompletingword(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(completingword("aBc 11c", ["accbbb", "abc", "abbc"]), "accbbb", 'example 1')

  def test_ex2(self):
    self.assertEqual(completingword("La1 abc", ["abcl", "baacl", "abaalc"]), "baacl", 'example 2')

  def test_ex3(self):
    self.assertEqual(completingword("JB 007", ["jj", "bb", "bjb"]), "bjb", 'example 3')

unittest.main()

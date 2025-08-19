#! /usr/bin/python3

from collections import defaultdict

def commoncharacters(a):
  mc = dict()
  first = True
  for s in a:
    mk = defaultdict(lambda: 0)
    for c in s:
      mk[c] += 1
    if first:
      mc = mk
      first = False
    else:
      ktr = set()
      for k in mc.keys():
        if k in mk:
          mc[k] = min(mc[k], mk[k])
        else:
          ktr.add(k)
      if len(ktr) > 0:
        for k in ktr:
          del mc[k]
  out = []
  kl = list(mc.keys())
  kl.sort()
  for c in kl:
    for _ in range(mc[c]):
      out.append(c)
  return out

import unittest

class TestCommoncharacters(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(commoncharacters(["bella", "label", "roller"]), ["e", "l", "l"], 'example 1')

  def test_ex2(self):
    self.assertEqual(commoncharacters(["cool", "lock", "cook"]), ["c", "o"], 'example 2')

  def test_ex3(self):
    self.assertEqual(commoncharacters(["hello", "world", "pole"]), ["l", "o"], 'example 3')

  def test_ex4(self):
    self.assertEqual(commoncharacters(["abc", "def", "ghi"]), [], 'example 4')

  def test_ex5(self):
    self.assertEqual(commoncharacters(["aab", "aac", "aaa"]), ["a", "a"], 'example 5')

unittest.main()

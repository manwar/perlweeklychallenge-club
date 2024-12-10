#! /usr/bin/python3

def replacewords(ww, a):
  out = []
  for w in a.split(" "):
    r = False
    for lw in ww:
      if w.find(lw) == 0:
        out.append(lw)
        r = True
        break
    if not r:
      out.append(w)
  return " ".join(out)

import unittest

class TestReplacewords(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(replacewords(["cat", "bat", "rat"], "the cattle was rattle by the battery"), "the cat was rat by the bat", 'example 1')

  def test_ex2(self):
    self.assertEqual(replacewords(["a", "b", "c"], "aab aac and cac bab"), "a a a c b", 'example 2')

  def test_ex3(self):
    self.assertEqual(replacewords(["man", "bike"], "the manager was hit by a biker"), "the man was hit by a bike", 'example 3')

unittest.main()

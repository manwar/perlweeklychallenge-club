#! /usr/bin/python3

import unittest

def rankscore(a):
  av = dict()
  for s in a:
    if s in av:
      av[s] += 1
    else:
      av[s] = 1
  kk = list(av.keys())
  kk.sort()
  kk.reverse()
  rank = 1
  tab = dict()
  for k in kk:
    siz = av[k]
    r = ""
    if rank <= 3:
      r = ["G", "S", "B"][rank - 1]
    else:
      r = str(rank)
    if siz > 1:
      r += "="
    tab[k] = r
    rank += siz
  return [tab[i] for i in a]

class TestRankscore(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(rankscore([1, 2, 4, 3, 5]), ["5", "4", "S", "B", "G"], 'example 1')

  def test_ex2(self):
    self.assertEqual(rankscore([8, 5, 6, 7, 4]), ["G", "4", "B", "S", "5"], 'example 2')

  def test_ex3(self):
    self.assertEqual(rankscore([3, 5, 4, 2]), ["B", "G", "S", "4"], 'example 3')

  def test_ex4(self):
    self.assertEqual(rankscore([2, 5, 2, 1, 7, 5, 1]), ["4=", "S=", "4=", "6=", "G", "S=", "6="], 'example 4')

unittest.main()

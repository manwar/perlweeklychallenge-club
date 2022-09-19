#! /usr/bin/python3

import unittest

def permutation2rank(perm):
  n = 0
  pp = perm.copy()
  pp.sort()
  oi = []
  l = 1
  for index in range(2,len(perm)+1):
    oi.append(l)
    l *= index
  oi.reverse()
  for index in range(len(perm)-1):
    base = {}
    for (i, e) in enumerate(pp):
      base[e] = i
    n += oi[index] * base[perm[index]]
    del base[perm[index]]
    pp = list(base.keys())
    pp.sort
  return n

def rank2permutation(perm, rank0):
  rank = rank0
  pp = perm.copy()
  pp.sort()
  o = []
  oi = []
  l = 1
  for index in range(2,len(perm)+1):
    oi.append(l)
    l *= index
  oi.reverse()
  for index in range(len(perm)-1):
    ix = rank // oi[index]
    o.append(pp[ix])
    pp = [i for i in pp if i != pp[ix]]
    rank %= oi[index]
  o.append(pp[0])
  return o

class TestPermRank(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(permutation2rank([1,0,2]),2,'example 1')

        def test_ex2(self):
          self.assertEqual(rank2permutation([0,1,2],1),[0,2,1],'example 1')

        def test_ex3(self):
          self.assertEqual(permutation2rank([2,0,3,1]),13,'example 1')

        def test_ex4(self):
          self.assertEqual(rank2permutation([1,3,2,0],7),[1,0,3,2],'example 1')

unittest.main()

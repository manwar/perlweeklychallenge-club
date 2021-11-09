#! /usr/bin/python3

import unittest

from math import sqrt

def splnum(n):
  k=int(sqrt(n))
  if k*k != n:
    return 0
  d=str(n)
  dl=len(d)-1
  for s in range(1,(1<<dl)):
    sa=[0]
    for i in range(dl):
      if s & (1<<i):
        sa.append(i+1)
    sa.append(dl+1)
    c=0
    for j in range(len(sa)-1):
      c+=int(d[sa[j]:sa[j+1]])
    if c==k:
      return 1
  return 0

class TestSplnum(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(splnum(81),1,'example 1')

        def test_ex2(self):
          self.assertEqual(splnum(9801),1,'example 2')

        def test_ex3(self):
          self.assertEqual(splnum(36),0,'example 3')

unittest.main()

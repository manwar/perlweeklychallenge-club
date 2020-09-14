#! /usr/bin/python

import unittest

def leader(a):
  m=int()
  o=list()
  for c in (reversed(a)):
    if (m==None or c > m):
      m=c;
      o.append(m)
  o.reverse()
  return o

class TestLeader(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(leader((9, 10, 7, 5, 6, 1)),[10, 7, 6, 1],'example 1')

    def test_ex2(self):
        self.assertEqual(leader((3, 4, 5)),[5,],'example 2')

unittest.main()

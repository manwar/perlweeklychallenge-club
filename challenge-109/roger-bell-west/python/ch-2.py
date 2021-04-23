#! /usr/bin/python3

import unittest

from itertools import permutations

def foursquare(src):
  sol=[]
  for t in permutations(src):
      b=t[1]+t[2]+t[3]
      if t[0]+t[1]==b:
        c=t[3]+t[4]+t[5]
        if b==c and c == t[5]+t[6]:
            sol=t
            break
  return sol

class TestFoursquare(unittest.TestCase):

        def test_ex1(self):
            q=foursquare([1,2,3,4,5,6,7])
            self.assertEqual(q[0],q[2]+q[3],'test 1')
            self.assertEqual(q[1]+q[2],q[4]+q[5],'test 2')
            self.assertEqual(q[3]+q[4],q[6],'test 3')

unittest.main()

#! /usr/bin/python3

import unittest
from collections import deque

def un(m):
  n=0
  s=[deque([1]),deque([1]),deque([1])]
  c=[2,3,5]
  for j in range(0,m):
    n=min(s[0][0],s[1][0],s[2][0])
    for i in range(0,2+1):
      if s[i][0]==n:
        s[i].popleft()
      s[i].append(n*c[i])
  return n

class TestUn(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(un(7),8,'example 1')

        def test_ex2(self):
          self.assertEqual(un(10),12,'example 2')

        def test_ex3(self):
          self.assertEqual(un(200),16200,'example 3')
          
unittest.main()

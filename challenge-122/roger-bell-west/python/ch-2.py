#! /usr/bin/python3

import unittest
import copy

def bs(n):
  o=list()
  p=list()
  p.append(list())
  while len(p) > 0:
    s=p.pop()
    t=sum(s)
    if t==n:
      o.append(s)
    else:
      for i in range(1,1+min(3,n-t)):
        q=copy.copy(s)
        q.append(i)
        p.append(q)
  o.reverse()
  return o

class TestBs(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(bs(4),[
            [1,1,1,1],
            [1,1,2],
            [1,2,1],
            [1,3],
            [2,1,1],
            [2,2],
            [3,1]
          ],'example 1') 

        def test_ex2(self):
          self.assertEqual(bs(5),[
            [1,1,1,1,1],
            [1,1,1,2],
            [1,1,2,1],
            [1,1,3],
            [1,2,1,1],
            [1,2,2],
            [1,3,1],
            [2,1,1,1],
            [2,1,2],
            [2,2,1],
            [2,3],
            [3,1,1],
            [3,2]
          ],'example 2')
         
unittest.main()

#! /usr/bin/python3

import unittest
from collections import deque

def pt(n):
  out=[]
  tri=deque()
  tri.append([3,4,5])
  while len(tri)>0:
    t=tri.popleft()
    for i in range(3):
      dm=divmod(n,t[i])
      if dm[1]==0:
        out.append([i*dm[0] for i in t])
    if min(t) <= n:
      tri.append([
        t[0]-2*t[1]+2*t[2],
        2*t[0]-1*t[1]+2*t[2],
        2*t[0]-2*t[1]+3*t[2],
      ])
      tri.append([
        t[0]+2*t[1]+2*t[2],
        2*t[0]+1*t[1]+2*t[2],
        2*t[0]+2*t[1]+3*t[2],
      ])
      tri.append([
        -t[0]+2*t[1]+2*t[2],
        -2*t[0]+1*t[1]+2*t[2],
        -2*t[0]+2*t[1]+3*t[2],
      ])
  return out

class TestPt(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(pt(5),[[3,4,5],[5,12,13]],'example 1')

        def test_ex2(self):
          self.assertEqual(pt(13),[[5,12,13],[13,84,85]],'example 2')

        def test_ex3(self):
          self.assertEqual(pt(1),[],'example 3')
          
unittest.main()

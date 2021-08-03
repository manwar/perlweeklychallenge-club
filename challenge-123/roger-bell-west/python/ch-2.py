#! /usr/bin/python3

import unittest

from math import degrees,atan2

def sp(m):
  for ordering in [
      [0,1,2,3,0],
      [0,1,3,2,0],
      [0,2,1,3,0],
      ]:
    w=[m[ordering[i%4]] for i in range(5)]
    ds=[]
    for pp in range(4):
      ds.append((w[pp+1][0]-w[pp][0])**2+(w[pp+1][1]-w[pp][1])**2)
    if min(ds) != max(ds):
      next
    angles=[]
    for pp in range(4):
      delta=[w[pp+1][i]-w[pp][i] for i in range(2)]
      if delta[0]==0:
        if delta[1]==0:
          return 0
        angle=90
        if delta[1]<0:
          angle=-90
      else:
        angle=degrees(atan2(delta[1],delta[0]))
      angles.append(angle)
    angles.append(angles[0])
    good=1
    deltas=[(angles[i+1]-angles[i]+360) % 360 for i in range(4)]
    if deltas[0] != 90 and deltas[0] != 270:
      continue
    else:
      for di in range(1,4):
        if deltas[di] != deltas[0]:
          good=0
          break
    return good
  return 0

class TestSp(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sp([[10,20],[20,20],[20,10],[10,10]]),1,'example 1')

        def test_ex2(self):
          self.assertEqual(sp([[12,24],[16,10],[20,12],[18,16]]),0,'example 2')

        def test_ex3(self):
          self.assertEqual(sp([[10,10],[20,0],[30,10],[20,20]]),1,'example 3')

        def test_ex4(self):
          self.assertEqual(sp([[0,0],[3,4],[8,4],[5,0]]),0,'example 4')
          
unittest.main()

#! /usr/bin/python3

import unittest

def msm(m):
  y=len(m)
  x=len(m[0])
  mxa=0
  oc=[]
  for yi in range(y):
    for xi in range(x):
      if m[yi][xi]==0:
        rl=[]
        mrl=x-xi
        for yj in range(yi,y):
          for xj in range(xi,min(xi+mrl,x)):
            if m[yj][xj] != 0:
              mrl=min(xj-xi,mrl)
              break
          rl.append(mrl)
        for n in range(len(rl)):
          if rl[n]>0:
            a=rl[n]*(n+1)
            if a >= mxa:
              mxa=a
              oc=[rl[n],n+1]
  o=[]
  for i in range(oc[1]):
    o.append([0] * oc[0])
  return o

class TestMsm(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(msm([[1,0,0,0,1,0],[1,1,0,0,0,1],[1,0,0,0,0,0]]),[[0,0,0],[0,0,0]],'example 1')

        def test_ex2(self):
          self.assertEqual(msm([[0,0,1,1],[0,0,0,1],[0,0,1,0]]),[[0,0],[0,0],[0,0]],'example 2')
          
unittest.main()

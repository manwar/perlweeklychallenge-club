#! /usr/bin/python3

import unittest

def fpp(n):
  o=set()
  chain=[["",0,0]]
  lim=(n-1)*4
  if n==1:
    lim=2
  while len(chain)>0:
    p=chain.pop()
    x=p[1]
    y=p[2]
    if y >= lim:
      o.add(p[0])
    else:
      mxx=y+1
      if y >= n:
        mxx=lim-y-1
      for txi in range(3):
        tx=x-1+txi
        if tx>=0 and tx<=mxx:
          if txi==0:
            chain.append([p[0]+'H',x-1,y+1])
          elif txi==1:
            chain.append([p[0]+'R',x,y+2])
          else:
            chain.append([p[0]+'L',x+1,y+1])
  y=list(o)
  y.sort()
  return y

  
class TestNs(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fpp(2),['LHLH','LHR','LLHH','LRH','RLH','RR'],'example 1')

        def test_ex2(self):
          self.assertEqual(fpp(1),['LH','R'],'example 2')
          
unittest.main()

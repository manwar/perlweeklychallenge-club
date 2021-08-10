#! /usr/bin/python3

import unittest

from math import degrees,atan2

def btd(tree):
  st=len(tree)
  depth=[0]*st
  diameter=[0]*st
  for i in range(st-1,-1,-1):
    if tree[i] != 0:
      a=i*2+1
      b=a+1
      if b < st:
        depth[i]=1+max(depth[a],depth[b])
        diameter[i]=max(
          depth[a]+depth[b],
          diameter[a],
          diameter[b]
          )
      else:
        depth[i]=1
  return diameter[0]

class TestBtd(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(btd([1,
                                2,5,
                                3,4,6,7,
                                0,0,0,0,0,0,8,10,
                                0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0]),6,'example 1')
          
unittest.main()

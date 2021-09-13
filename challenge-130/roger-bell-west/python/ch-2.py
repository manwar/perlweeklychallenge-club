#! /usr/bin/python3

import unittest

def bst(tree):
  limit=[]
  for i in range(len(tree)):
    limit.append([tree[i],tree[i]])
  for s in range(int((len(tree)-1)/2)-1,-1,-1):
    child=s*2+1
    for sb in range(2):
      ac=child+sb
      if sb==0 and tree[s]!=0 and limit[ac][1] > tree[s]:
        return 0
      if sb==1 and limit[ac][0]!=0 and limit[ac][0] < tree[s]:
        return 0
    limit[s]=[tree[s],max(tree[s],limit[child+1][1])]
    if limit[child][0] > 0:
      limit[s][0]=min(tree[s],limit[child][0])
  return 1

class TestBst(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(bst([
            8,
            5,      9,
            4,  6,  0,  0
          ]),1,'example 1')

        def test_ex2(self):
          self.assertEqual(bst([
            5,
            4,      7,
            3,  6,  0,  0
          ]),0,'example 2')

unittest.main()

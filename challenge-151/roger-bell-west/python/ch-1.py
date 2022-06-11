#! /usr/bin/python3

import unittest

def str2tree(str):
  o=[0]
  d=0
  p=0
  for e in str.split():
    if e == '|':
      d += 1
      p=0
      m=(1<<(d+1))-1
      while len(o) < m:
        o.append(0)
    else:
      if e == '*':
        y=0
      else:
        y=int(e)
      i = (1<<d) - 1 + p
      o[i]=y
      p += 1
  return o

def mindepth(tree):
  firstleaf=len(tree)
  for i,e in enumerate(tree):
    if e==0:
      continue
    elif (i+1) << 1 >= len(tree):
      firstleaf=i
      break
    else:
      ni=((i+1) << 1) -1
      if tree[ni]==0 and tree[ni+1]==0:
        firstleaf=i
        break
  t=firstleaf+1
  d=0
  while t > 0:
    t >>= 1
    d += 1
  return d

class TestStr2tree(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(mindepth(str2tree("1 | 2 3 | 4 5")),2,'example 1')

        def test_ex2(self):
          self.assertEqual(mindepth(str2tree("1 | 2 3 | 4 *  * 5 | * 6")),3,'example 2')

unittest.main()

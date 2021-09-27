#! /usr/bin/python3

import unittest

def hj(a,b,c,d):
  h=[a,c]
  i=[b,d]
  m=dict()
  for x in range(2):
    j=1-i[x]
    for y in range(len(h[x])):
      if not h[x][y][i[x]] in m:
        m[h[x][y][i[x]]]=[[],[]]
      m[h[x][y][i[x]]][x].append(h[x][y][j])
  o=[]
  for k in sorted(m.keys()):
    for a in m[k][0]:
      for b in m[k][1]:
        o.append([a,k,b])
  return o

class TestHj(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(hj([[20,"Alex"],[28,"Joe"],[38,"Mike"],[18,"Alex"],[25,"David"],[18,"Simon"]],1,[["Alex","Stewart"],["Joe","Root"],["Mike","Gatting"],["Joe","Blog"],["Alex","Jones"],["Simon","Duane"]],0),[[20,"Alex","Stewart"],[20,"Alex","Jones"],[18,"Alex","Stewart"],[18,"Alex","Jones"],[28,"Joe","Root"],[28,"Joe","Blog"],[38,"Mike","Gatting"],[18,"Simon","Duane"],],'example 1')

unittest.main()

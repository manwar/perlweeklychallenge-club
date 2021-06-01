#! /usr/bin/python3

import unittest

from collections import defaultdict

def sc(*n):
  m=list()
  i=defaultdict(list)
  for t in n:
    m.append(t[-1])
    i[t[0]].append(len(m)-1)
  chain=list([[0]])
  while len(chain)>0:
    stub=chain.pop()
    v=set(range(len(n)))
    for x in stub:
      v.remove(x)
    if len(v)>0:
      if m[stub[-1]] in i:
        for x in filter (lambda y: y in v, i[m[stub[-1]]]):
          s=stub
          s.append(x)
          chain.append(s)
    else:
      return 1
  return 0

class TestSc(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sc('abc','dea','cd'),1,'example 1')
          
        def test_ex2(self):
          self.assertEqual(sc('ade','cbd','fgh'),0,'example 2')

        def test_ex3(self):
          self.assertEqual(sc('abc','dea','fgh','hif'),0,'example 3')
          
        def test_ex4(self):
          self.assertEqual(sc('abc','dec','cfa','cgd'),1,'example 4')

unittest.main()

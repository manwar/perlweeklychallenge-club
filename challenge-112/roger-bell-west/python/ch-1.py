#! /usr/bin/python3

import unittest

def cp(i):
  p=[x for x in i.split('/') if x != '' and x != '.']
  d=True
  while d:
    d=False
    for pi in range(1,len(p)):
      if p[pi] == '..':
        p=p[0:pi-2]+p[pi+1:-1]
        d=True
        break
  return '/'+'/'.join(p)

class TestCp(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(cp('/a/'),'/a','example 1')
          
        def test_ex2(self):
          self.assertEqual(cp('/a/b//c/'),'/a/b/c','example 2')
          
        def test_ex3(self):
          self.assertEqual(cp('/a/b/c/../..'),'/a','example 3')
          
        def test_ex4(self):
          self.assertEqual(cp('/a/./b'),'/a/b','example 4')

unittest.main()

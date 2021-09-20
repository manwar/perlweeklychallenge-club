#! /usr/bin/python3

import unittest

def fp(delims,sample):
  d=[set(),set()]
  for i in range(len(delims)):
    d[i%2].add(delims[i])
  o=[[],[]]
  for s in sample:
    for x in [0,1]:
      if s in d[x]:
        o[x].append(s)
  return ["".join(o[x]) for x in [0,1]]

class TestFp(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(fp('""[]()','"I like (parens) and the Apple ][+" they said.'),['"(["','")]"'],'example 1')

        def test_ex2(self):
          self.assertEqual(fp('**//<>','/* This is a comment (in some languages) */ <could be a tag>'),['/**/<','/**/>'],'example 2')

unittest.main()

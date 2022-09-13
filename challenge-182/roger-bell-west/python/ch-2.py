#! /usr/bin/python3

from collections import defaultdict

import unittest

def commonpath(p):
  pa = []
  pl = []
  for sp in p:
    q = sp.split("/")
    pl.append(len(q))
    pa.append(q)
  out = []
  for cl in range(min(pl)):
    ex = False
    tx = pa[0][cl]
    for pe in pa:
      if pe[cl] != tx:
        ex = True
        break
    if ex:
      break
    out.append(tx)
  return "/".join(out)

class TestCommonpath(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(commonpath([
            "/a/b/c/1/x.pl",
            "/a/b/c/d/e/2/x.pl",
            "/a/b/c/d/3/x.pl",
            "/a/b/c/4/x.pl",
            "/a/b/c/d/5/x.pl"
          ]),
                           "/a/b/c", 'example 1')

unittest.main()

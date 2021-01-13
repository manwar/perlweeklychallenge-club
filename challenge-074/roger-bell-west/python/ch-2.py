#! /usr/bin/python3

import unittest

def fnr(i):
    s=dict()
    ls=list()
    o=list()
    for c in list(i):
        ls.append(c)
        s.setdefault(c,0)
        s[c] += 1
        ls=[x for x in ls if s[x]<2]
        if len(ls)>0:
            o.append(ls[len(ls)-1])
        else:
            o.append('#')
    return ''.join(o)

class TestMajority(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(fnr('ababc'),'abb#c','example 1')

    def test_ex2(self):
        self.assertEqual(fnr('xyzzyx'),'xyzyx#','example 2')

unittest.main()

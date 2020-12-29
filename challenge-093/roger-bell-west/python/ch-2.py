#! /usr/bin/python3

import collections

def sp(*t):
    s=0
    path=collections.deque([[0]])
    while len(path)>0:
        a=path.popleft()
        c=(a[-1]+1)*2-1
        tn=1
        for ac in range(c,c+2):
            if ac < len(t) and t[ac] is not None:
                b=a.copy()
                b.append(ac)
                path.append(b)
                tn=0
        if tn:
            s += sum(t[i] for i in a)
    return s

import unittest

class TestSp(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(sp(1,2,None,3,4),13,'example 1');

    def test_ex2(self):
        self.assertEqual(sp(1,2,3,4,None,5,6),26,'example 2');

unittest.main()

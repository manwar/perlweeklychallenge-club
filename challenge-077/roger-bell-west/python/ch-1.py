#! /usr/bin/python3

import unittest
from itertools import combinations

def psum(n):
    p=[1,1]
    while (p[-1]<=n):
        p.append(p[-1]+p[-2])
    del p[0]
    o=list()
    for l in range (1,len(p)):
        for c in combinations(p,l):
            if (sum(c)==n):
                o.append(c)
                break
    return o

class TestMajority(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(psum(6),[(1, 5), (1, 2, 3)],'example 6-2')

    def test_ex2(self):
        self.assertEqual(psum(9),[(1, 8), (1, 3, 5)],'example 9-2')

unittest.main()

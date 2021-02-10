#! /usr/bin/python3

from collections import defaultdict

def us(text,match):
    s=defaultdict(list)
    for i,c in enumerate(text):
        s[c].append(i)
    j=list()
    for c in match:
        if c in s:
            j.append(s[c])
        else:
            return 0
    o=list();
    for i in range(len(j[0])):
        o.append(1)
    for m in range(1,len(j)):
        n=list()
        for bi in range(len(j[m])):
            t=0
            for ai in range(len(j[m-1])):
                if j[m-1][ai] < j[m][bi]:
                    t += o[ai]
            n.append(t)
        o=n
    return sum(o)

import unittest

class TestUs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(us('littleit','lit'),5,'example 1')

    def test_ex2(self):
        self.assertEqual(us('london','lon'),3,'example 2')

unittest.main()

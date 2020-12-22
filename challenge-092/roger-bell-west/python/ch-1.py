#! /usr/bin/python3

def isos(a,b):
    if len(a) != len(b):
        return 0
    s=[a,b]
    lt=[dict(),dict()]
    n=[0,0]
    for ci in range(0,len(a)):
        r=list()
        for si in 0,1:
            if s[si][ci] in lt[si]:
                r.append(lt[si][s[si][ci]])
            else:
                lt[si][s[si][ci]]=n[si]
                r.append(n[si])
                n[si]+=1
        if r[0] != r[1]:
            return 0
    return 1

import unittest

class TestIsos(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(isos('abc','xyz'),1,'example 1');

    def test_ex2(self):
        self.assertEqual(isos('abb','xyy'),1,'example 2');

    def test_ex3(self):
        self.assertEqual(isos('sum','add'),0,'example 3');

unittest.main()

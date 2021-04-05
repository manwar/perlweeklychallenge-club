#! /usr/bin/python3

def sdn(count):
    r=list()
    n=10
    while len(r) < count:
        ns=[int(i) for i in "{:d}".format(n)]
        d=[0]*10
        for i in ns:
            d[i]+=1
        sd=True
        for i in range(len(ns)):
            if d[i] != ns[i]:
                sd=False
                break
        if sd and len(ns)<10:
            for i in range(len(ns),10):
                if d[i] != 0:
                    sd=False
                    break
        if sd:
            r.append(n)
        n+=10
    return r

import unittest

class TestSdn(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(sdn(3),[1210, 2020, 21200],'example 1')

unittest.main()

#! /usr/bin/python3

import unittest
from math import sqrt

def cbs(*strs):
    bss=map(bs,strs)
    r=set()
    f=False
    for bsa in bss:
        if (f):
            s=set(bsa)
            r=r & s
        else:
            r=set(bsa)
            f=True
    return sorted(r)

def bs(str):
    sl=len(str)
    f=dict()
    for n in range(1,int(sqrt(sl))+1):
        p=sl/n
        if (p == int(p)):
            f[n]=p
            f[p]=n
    out=list()
    for l in sorted(f.keys()):
        q=str[0:int(l)]
        if (q * int(f[l]) == str):
            out.append(q)
    return out

class TestCbs(unittest.TestCase):

    def test_bs1(self):
        self.assertEqual(bs('abcdabcd'),['abcd','abcdabcd'],'bs-only 1')

    def test_bs2(self):
        self.assertEqual(bs('aaa'),['a','aaa'],'bs-only 2')

    def test_ex1(self):
        self.assertEqual(cbs('abcdabcd','abcdabcdabcdabcd'),['abcd','abcdabcd'],'example 1')

    def test_ex2(self):
        self.assertEqual(cbs('aaa','aa'),['a',],'example 2')

unittest.main()

#! /usr/bin/python3

from collections import defaultdict

def diff(a,b):
    d=0
    for i in range(len(a)):
        if a[i] != b[i]:
            d += 1
    return d

def bs(b,s):
    bb=list()
    i=0
    while i<len(b):
        bb.append(b[i:i+s])
        i+=s
    if len(bb[len(bb)-1]) != s:
        return -1
    mc=-1
    cost=defaultdict(dict)
    for x in range(len(bb)-1):
        cost[x][x]=0
        for y in range(x+1,len(bb)):
            t=diff(bb[x],bb[y])
            cost[x][y]=t
            cost[y][x]=t
        tc=sum(cost[x][i] for i in range(len(bb)))
        if mc==-1 or tc < mc:
            mc=tc
    return mc

import unittest
    
class TestBs(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(bs('101100101',3),1,'example 1')

    def test_ex2(self):
        self.assertEqual(bs('00011011',2),4,'example 2')

unittest.main()

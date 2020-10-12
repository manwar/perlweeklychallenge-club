#! /usr/bin/python3

import unittest
from collections import deque

def isinterleave(a,b,c):
    l=list(map(len,(a,b,c)))
    buf=deque()
    buf.append([0,0,0])
    while (buf):
        n=buf.popleft()
        if (n[2] >= l[2]):
            return 1
        if ((n[0] < l[0]) and (a[n[0]] == c[n[2]])):
            buf.append([n[0]+1,n[1],n[2]+1])
        if ((n[1] < l[1]) and (b[n[1]] == c[n[2]])):
            buf.append([n[0],n[1]+1,n[2]+1])
    return 0

class TestInterleave(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(isinterleave('XY','X','XXY'),1,'example 1')

    def test_ex2(self):
        self.assertEqual(isinterleave('XXY','XXZ','XXXXZY'),1,'example 2')

    def test_ex3(self):
        self.assertEqual(isinterleave('YX','X','XXY'),0,'example 3')

    def test_ex4(self):
        self.assertEqual(isinterleave('ACF','BDEG','ABCDEFG'),1,'example 4')

    def test_ex5(self):
        self.assertEqual(isinterleave('ACF','BDGE','ABCDEFG'),0,'example 5')

unittest.main()

#! /usr/bin/python3

def mp(*cx):
    epsilon=0.0001
    mxp=0
    for a in range(0,len(cx)-2):
        for b in range(a+1,len(cx)-1):
            d=[cx[b][i]-cx[a][i] for i in range(2)]
            pil=2
            for c in range(b+1,len(cx)):
                tp=0;
                v=[cx[c][i]-cx[a][i] for i in range(2)]
                if d[0]==0:
                    if v[0]==0:
                        tp=1
                elif d[1]==0:
                    if v[1]==0:
                        tp=1
                elif abs(float(v[0])/float(d[0])-float(v[1])/float(d[1])) < epsilon:
                    tp=1
                if tp:
                    pil += 1
            if pil > mxp:
                mxp=pil
    return mxp

import unittest

class TestMp(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(mp([1,1], [2,2], [3,3]),3,'example 1');

    def test_ex2(self):
        self.assertEqual(mp([1,1], [2,2], [3,1], [1,3], [5,3]),3,'example 2');

unittest.main()

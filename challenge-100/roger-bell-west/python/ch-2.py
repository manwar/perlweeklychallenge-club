#! /usr/bin/python3

def ts(inp):
    b=list()
    n=0
    i=0
    s=inp[0][0]
    r=list()
    while 1:
        if len(b)>0:
            t=b.pop()
            (n,i,s)=t
        if (n < len(inp)-1):
            n += 1
            for ix in range(i,i+2):
                b.append([n,ix,s+inp[n][ix]])
        else:
             r.append(s)   
        if len(b)==0:
            break;
    return min(r)

import unittest

class TestFt(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(ts([[1],[2,4],[6,4,9],[5,1,7,2]]),8,'example 1')

        def test_ex2(self):
            self.assertEqual(ts([[3],[3,1],[5,2,3],[4,3,1,3]]),7,'example 2')

unittest.main()

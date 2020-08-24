#! /usr/bin/python3

import unittest

def coinsum(c,s):
    m=list()
    for i in range(len(c)):
        m.append(int(s/c[i]))
    out=list()
    b=[0 for i in range(len(c))]
    of=1
    while of:
        v=sum(c[i]*b[i] for i in range(len(c)))
        if v==s:
            out.append(b.copy())
        i=0
        while 1:
            b[i]+=1
            if b[i]>m[i]:
                b[i]=0
                i+=1
                if i>len(b)-1:
                    of=0
                    break;
            else:
                break;
    return len(out)
            
class TestMajority(unittest.TestCase):

    def test_ex(self):
        self.assertEqual(coinsum((1,2,4),6),6,'example')

unittest.main()

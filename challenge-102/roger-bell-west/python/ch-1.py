#! /usr/bin/python3

import math

def is_rare(t: str):
    d=t[::-1]
    dn=int(d)
    tn=int(t)
    if dn >= tn:
        return 0
    for cn in [tn+dn,tn-dn]:
        cm=cn % 10
        if cm==2 or cm==3 or cm==7 or cm==8:
            return 0
        s=int(math.sqrt(cn))
        if s*s != cn:
            return 0
    return 1

def rn(d):
    out=list()
    mxm=10**(d-2)-1
    for a in [2,4,6,8]:
        for q in [0,2,3,5,7,8]:
            if a==2 and q!=2:
                continue
            if a==4 and q!=0:
                continue
            if a==6 and q!=0 and q!=5:
                continue
            if a==8 and q!=2 and q!=3 and q!=7 and q!=8:
                continue
            if d==2:
                ts=str(a) + str(q)
                if is_rare(ts):
                    out.append(int(ts))
            else:
                for md in range(mxm+1):
                    mds=("{:0"+str(d-2)+"d}").format(md)
                    b=int(mds[0])
                    p=int(mds[len(mds)-1])
                    if a==2 and b!=p:
                        continue
                    if a==4 and abs(b-p)%2 != 0:
                        continue
                    if a==6 and abs(b-p)%2 != 1:
                        continue
                    if a==8:
                        if q==2 and b+p != 9:
                            continue
                        if q==3 and b-p != 7 and p-b != 3:
                            continue
                        if q==7 and b+p != 1 and b+p != 11:
                            continue
                        if q==8 and b!=p:
                            continue
                    ts=str(a)+mds+str(q)
                    if is_rare(ts):
                        out.append(int(ts))
    return out                    


import unittest

class TestRn(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(rn(2),[65],'example 1')

        def test_ex2(self):
            self.assertEqual(rn(6),[621770],'example 2')

        def test_ex3(self):
            self.assertEqual(rn(9),[281089082],'example 3')

unittest.main()

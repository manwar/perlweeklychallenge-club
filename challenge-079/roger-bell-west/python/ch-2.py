#! /usr/bin/python

import unittest

from math import log10

def capacity(n):
    cap=0
    for r in range(min(n),max(n)+1):
        b=[i for i in range(0,len(n)) if n[i] >= r]
        if(len(b)>1):
            for i in range(0,len(b)-1):
                cap += b[i+1]-b[i]-1
    return cap

def histo(n):
    mx=max(n)
    cw=int(log10(mx+1)+.9999);
    for r in reversed(range(1,mx+1)):
        row=list()
        row.append(format(r,str(cw)))
        for i in range(0,len(n)):
            s = ' '
            if(n[i] >= r):
                s = '#'
            s *= cw
            row.append(s)
        print(' '.join(row))
    s='-' * cw;
    print(' '.join([s for i in range(0,len(n)+1)]))
    row=list()
    row.append(' ' * cw)
    for i in n:
        row.append(format(i,str(cw)))
    print(' '.join(row))
         
histo((2,1,4,1,2,5));
histo((3,1,3,1,1,5));

class TestCapacity(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(capacity((2,1,4,1,2,5)),6,'example 1')

    def test_ex2(self):
        self.assertEqual(capacity((3,1,3,1,1,5)),6,'example 2')

unittest.main()

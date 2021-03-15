#! /usr/bin/python3

def cc(s,n):
    plain=list([chr(i) for i in range(ord('A'),ord('Z')+1)])
    cmap=dict()
    asize=len(plain)
    for p in range(asize):
        c=(p+asize*2-n) % asize
        cmap[plain[p]]=plain[c]
    out=""
    for i in range(len(s)):
        if s[i] in cmap:
            out += cmap[s[i]]
        else:
            out += s[i]
    return out
    
import unittest

class TestCc(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(cc('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG',3),'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD','example 1')

    def test_ex2(self):
        self.assertEqual(cc('QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD',-3),'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG','example 2')

    def test_ex3(self):
        self.assertEqual(cc('A QUICK MOVEMENT OF THE ENEMY WILL JEOPARDIZE SIX GUNBOATS',13),'N DHVPX ZBIRZRAG BS GUR RARZL JVYY WRBCNEQVMR FVK THAOBNGF','example 3')

unittest.main()

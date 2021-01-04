#! /usr/bin/python3

def bt2ll(*tree):
    return recurse(tree,0)

def recurse(tree,start):
    out=list([tree[start]])
    b=start*2+1
    for ba in range(b,b+2):
        if ba < len(tree) and tree[ba] is not None:
            for t in recurse(tree,ba):
                out.append(t)
    return out
    
import unittest

class TestBt2ll(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(bt2ll(1,2,3,4,5,None,None,None,None,6,7),[1,2,4,5,6,7,3],'example 1');

unittest.main()

#! /usr/bin/python3

from collections import defaultdict

def ga(*l):
    g=defaultdict(set)
    for word in l:
        g[wh(word)].add(word)
    r=set()
    for v in g.values():
        r.add(frozenset(v))
    return r

def wh(word):
    w=word.lower()
    if not w.isalpha():
        return 0
    b=ord('a')
    p=list([2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101])
    n=1
    for c in w:
        n *= p[ord(c)-b]
    return n
    
import unittest

class TestGa(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(ga('opt','bat','saw','tab','pot','top','was'),{frozenset({'bat','tab'}),frozenset({'opt','pot','top'}),frozenset({'saw','was'})},'example 1');

    def test_ex2(self):
        self.assertEqual(ga('x'),{frozenset({'x'})},'example 2');

unittest.main()

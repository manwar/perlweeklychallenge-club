### https://theweeklychallenge.org/blog/perl-weekly-challenge-285/
"""

Task 1: No Connection

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of routes, @routes.

   Write a script to find the destination with no further outgoing
   connection.

Example 1

Input: @routes = (["B","C"], ["D","B"], ["C","A"])
Output: "A"

"D" -> "B" -> "C" -> "A".
"B" -> "C" -> "A".
"C" -> "A".
"A".

Example 2

Input: @routes = (["A","Z"])
Output: "Z"

Task 2: Making Change
"""
### solution by pokgopun@gmail.com

def nc(routes: tuple):
    dct = dict()
    for src,dst in routes:
        if dct.get(src,True):
            dct[src] = False
        dct.setdefault(dst,True)
    for k,v in dct.items():
        if v:
            return k
    return None

import unittest

class TestNc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (("B","C"), ("D","B"), ("C","A")): "A",
                (("A","Z"),): "Z",
                }.items():
            self.assertEqual(nc(inpt),otpt)

unittest.main()

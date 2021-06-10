#! /usr/bin/python3

def memoize(f):
    memo = {}
    def helper(x):
        if x not in memo:            
            memo[x] = f(x)
        return memo[x]
    return helper

@memoize
def fusc(n):
    if n==0:
        return 0
    elif n==1:
        return 1
    elif n%2==0:
        return fusc(n/2)
    else:
        h=(n-1)/2
        return fusc(h)+fusc(h+1)

def fuscseq(m):
    return [fusc(i) for i in range(m)]

import unittest

class TestFusc(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(fuscseq(50),[0, 1, 1, 2, 1, 3, 2, 3, 1, 4, 3, 5, 2, 5, 3, 4, 1, 5, 4, 7, 3, 8, 5, 7, 2, 7, 5, 8, 3, 7, 4, 5, 1, 6, 5, 9, 4, 11, 7, 10, 3, 11, 8, 13, 5, 12, 7, 9, 2, 9],'example 1')

unittest.main()

#!/usr/bin/python3

'''

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #2: Palindromic Prime Cyclops

    Write a script to generate first 20 Palindromic Prime Cyclops Numbers.

'''

import math
import unittest

def isPrime(n) -> bool:
    if n == 1:
        return False

    i = 3
    while (i <= int(math.sqrt(n))):
        if ((n % i) == 0):
            return False
        i += 2

    return True

def isPalindrome(n) -> bool:
    return str(n) == str(n) [::-1]

def grep(l, s) -> bool:
    x = [i for i in l if s == i]
    if len(x) == 0:
        return False

    return True

def isCyclops(n) -> bool:
    l = [int(a) for a in str(n)]
    m = int((len(l) - 1) / 2)

    if len(l) % 2 == 0 or l[m] != 0 or grep(l[0:m-1],0) or grep(l[m+1:],0):
        return False

    return True

def getPalindromicPrimeCyclops(n):
    ppc = []
    i   = 101
    while len(ppc) < n:
        if isPalindrome(i) and isPrime(i) and isCyclops(i):
            ppc.append(i)

        i = i + 2

    return ppc

#
#
# Unit test class

class TestPalindromicPrimeCyclops(unittest.TestCase):
    def test_PalindromicPrimeCyclops(self):
        got = getPalindromicPrimeCyclops(20)
        exp = [
              101,   16061,   31013,   35053,   38083,   73037,   74047,
            91019,   94049, 1120211, 1150511, 1160611, 1180811, 1190911,
          1250521, 1280821, 1360631, 1390931, 1490941, 1520251,
        ]
        self.assertEqual(got, exp, 'Example')

unittest.main()

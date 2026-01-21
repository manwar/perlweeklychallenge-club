### https://theweeklychallenge.org/blog/perl-weekly-challenge-357/
"""

Task 1: Kaprekar Constant

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   Write a function that takes a 4-digit integer and returns how many
   iterations are required to reach Kaprekar’s constant (6174). For more
   information about Kaprekar's Constant please follow the [44]wikipedia
   page.

Example 1

Input: $int = 3524
Output: 3

Iteration 1: 5432 - 2345 = 3087
Iteration 2: 8730 - 0378 = 8352
Iteration 3: 8532 - 2358 = 6174

Example 2

Input: $int = 6174
Output: 0

Example 3

Input: $int = 9998
Output: 5

Iteration 1: 9998 - 8999 = 0999
Iteration 2: 9990 - 0999 = 8991
Iteration 3: 9981 - 1899 = 8082
Iteration 4: 8820 - 0288 = 8532
Iteration 5: 8532 - 2358 = 6174

Example 4

Input: $int = 1001
Output: 4

Iteration 1: 1100 - 0011 = 1089
Iteration 2: 9810 - 0189 = 9621
Iteration 3: 9621 - 1269 = 8352
Iteration 4: 8532 - 2358 = 6174

Example 5

Input: $int = 9000
Output: 4

Iteration 1: 9000 - 0009 = 8991
Iteration 2: 9981 - 1899 = 8082
Iteration 3: 8820 - 0288 = 8532
Iteration 4: 8532 - 2358 = 6174

Example 6

Input: $int = 1111
Output: -1

The sequence does not converge on 6174, so return -1.

Task 2: Unique Fraction Generator
"""
### solution by pokgopun@gmail.com

def kc(n: int) -> int:
    if n < 0 or n > 9999:
        return None
    c = 0
    while c <= 7:
        if n == 6174:
            break
        ints = []
        while n > 0:
            ints.append(n % 10)
            n //= 10
        ints.sort()
        for i in range(4 - len(ints)):
            ints.insert(0, 0)
        i = 4
        t = 1
        for v in ints:
            i -= 1
            n += t*(v - ints[i])
            t *= 10
        if n == 0:
            return -1
        c += 1
        #print(n, c)
    return c

def genFullTestSet():
    counts = tuple()
    for n in range(10000):
        if n == 6174:
            counts = (0,)
        else:
            if len(set(int(e) for e in f'{n:04d}')) == 1:
                counts = (-1,)
            else:
                counts = (1,2,3,4,5,6,7)
        yield n, counts

def contains(ints: tuple[int], n: int) -> bool:
    try:
        ints.index(n)
    except:
        return False
    return True

import unittest

class TestKc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                3524: 3,
                6174: 0,
                9998: 5,
                1001: 4,
                9000: 4,
                1111: -1,
                }.items():
            #print(inpt, "=>", otpt)
            self.assertEqual(kc(inpt), otpt)
        for n, counts in genFullTestSet():
            #print(n, "=>", counts)
            self.assertEqual(contains(counts, kc(n)), True)

unittest.main()

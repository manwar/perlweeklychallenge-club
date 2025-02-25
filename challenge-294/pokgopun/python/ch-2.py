### https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
"""

Task 2: Next Permutation

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find out the next permutation of the given array.

     The next permutation of an array of integers is the next
     lexicographically greater permutation of its integer.

Example 1

Input: @ints = (1, 2, 3)
Output: (1, 3, 2)

Permutations of (1, 2, 3) arranged lexicographically:
(1, 2, 3)
(1, 3, 2)
(2, 1, 3)
(2, 3, 1)
(3, 1, 2)
(3, 2, 1)

Example 2

Input: @ints = (2, 1, 3)
Output: (2, 3, 1)

Example 3

Input: @ints = (3, 1, 2)
Output: (3, 2, 1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 10th November
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

### from https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/ referred by Week174

def permutation_rank(p):
    """Given a permutation of {0,..,n-1} find its rank according to lexicographical order

       :param p: list of length n containing all integers from 0 to n-1
       :returns: rank between 0 and n! -1
       :beware: computation with big numbers
       :complexity: `O(n^2)`
    """
    n = len(p)
    fact = 1                                 # compute (n-1) factorial
    for i in range(2, n):
        fact *= i
    r = 0                                    # compute rank of p
    digits = list(range(n))                  # all yet unused digits
    for i in range(n-1):                     # for all digits except last one
        q = digits.index(p[i])
        r += fact * q
        del digits[q]                        # remove this digit p[i]
        fact //= (n - 1 - i)                 # weight of next digit
    return r

def rank_permutation(r, n):
    """Given r and n find the permutation of {0,..,n-1} with rank according to lexicographical order equal to r

       :param r n: integers with 0 ≤ r < n!
       :returns: permutation p as a list of n integers
       :beware: computation with big numbers
       :complexity: `O(n^2)`
    """
    fact = 1                                # compute (n-1) factorial
    for i in range(2, n):
        fact *= i
    digits = list(range(n))                 # all yet unused digits
    p = []                                  # build permutation
    for i in range(n):
        q = r // fact                       # by decomposing r = q * fact + rest
        r %= fact
        p.append( digits[q] )
        del digits[q]                       # remove digit at position q
        if i != n - 1:
            fact //= (n - 1 - i)            # weight of next digit
    return p

from typing import Tuple

def np(ints: Tuple[int]) -> Tuple[int]:
    r = permutation_rank([e - 1 for e in ints])
    #print("r =", r)
    return tuple(e + 1 for e in rank_permutation(r + 1, len(ints)))

import unittest

class TestNp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 2, 3): (1, 3, 2),
                (2, 1, 3): (2, 3, 1),
                (3, 1, 2): (3, 2, 1),
                }.items():
            self.assertEqual(np(inpt),otpt)

unittest.main()
 

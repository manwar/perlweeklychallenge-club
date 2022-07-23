#!/usr/bin/python3

'''

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #2: Permutation Ranking

    You are given a list of integers with no duplicates, e.g. [0, 1, 2].

    Write two functions, permutation2rank() which will take the list
    and determine its rank (starting at 0) in the set of possible
    permutations arranged in lexicographic order, and rank2permutation()
    which will take the list and a rank number and produce just that
    permutation.

'''

import unittest
import itertools

def permutation2rank(array):
    array.sort()
    return list(itertools.permutations(array))

def rank2permutation(array, rank):
    p2r = permutation2rank(array)
    return p2r[rank]

#
#
# Unit test class

class TestPermutationRanking(unittest.TestCase):
    def test_permutation2rank(self):
        exp = [ (0, 1, 2),
                (0, 2, 1),
                (1, 0, 2),
                (1, 2, 0),
                (2, 0, 1),
                (2, 1, 0),
              ]
        got = permutation2rank([1, 0, 2])
        self.assertEqual(exp, got)

    def test_rank2permutation(self):
        exp = (0, 2, 1)
        got = rank2permutation([1, 0, 2], 1)
        self.assertEqual(exp, got)

unittest.main()

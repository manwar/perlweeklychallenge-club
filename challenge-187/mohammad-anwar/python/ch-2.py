#!/usr/bin/python3

'''

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #2: Magical Triplets

    You are given a list of positive numbers, @n, having at least
    3 numbers.

    Write a script to find the triplets (a, b, c) from the given list
    that satisfies the following rules.

    1. a + b > c
    2. b + c > a
    3. a + c > b
    4. a + b + c is maximum.

    In case, you end up with more than one triplets having the maximum
    then pick the triplet where a >= b >= c.

'''

import unittest
import itertools

def magicalTriplets(array):
    array.sort()
    magical = {}
    for triplet in itertools.permutations(array, 3):
        triplet_list = list(triplet)
        triplet_list.sort(reverse=True)
        a = triplet_list[0]
        b = triplet_list[1]
        c = triplet_list[2]
        if (a + b > c) and (b + c > a) and (a + c > b):
            key = ':'.join([str(i) for i in triplet_list])
            val = sum(triplet_list)
            magical[key] = val

    if len(magical) == 0:
        return []

    magical_triplet = sorted(magical, key=magical.get, reverse=True)[0]
    return [int(i) for i in magical_triplet.split(":")]

#
#
# Unit test class

class TestMagicalTriplets(unittest.TestCase):
    def test_MagicalTriplets(self):
        self.assertEqual(magicalTriplets([1, 2, 3, 2]), [3, 2, 2], 'Example 1')
        self.assertEqual(magicalTriplets([1, 3, 2]),    [],        'Example 2')
        self.assertEqual(magicalTriplets([1, 1, 2, 3]), [],        'Example 3')
        self.assertEqual(magicalTriplets([2, 4, 3]),    [4, 3, 2], 'Example 4')

unittest.main()

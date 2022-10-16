#!/usr/bin/python3

'''

Week 186:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-186

Task #1: Zip List

    You are given two list @a and @b of same size.

    Create a subroutine sub zip(@a, @b) that merge the two list.

'''

import unittest

def zip(a, b):
    list = a + b
    size = len(a)

    zip = []
    for i in range(size):
        zip.append(list[i])
        zip.append(list[i + size])

    return zip

#
#
# Unit test class

class TestZipList(unittest.TestCase):
    def test_zipList(self):
        a = [1, 2, 3]
        b = ['a', 'b', 'c']
        self.assertEqual(zip(a, b), [1, 'a', 2, 'b', 3, 'c'])
        self.assertEqual(zip(b, a), ['a', 1, 'b', 2, 'c', 3])

unittest.main()

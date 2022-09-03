#!/usr/bin/python3

'''

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #1: First Unique Character

    You are given a string, $s.

    Write a script to find out the first unique character in the
    given string and print its index (0-based).

'''

import unittest

def firstUniqueCharacter(str) -> int:
    char_list = []
    char_hash = {}
    for c in list(str):
        if c == ' ':
            next
        c = c.lower()

        if c in char_hash:
            char_hash[c] += 1
        else:
            char_list.append(c)
            char_hash[c] = 1

    i = 0
    for c in char_list:
        if char_hash[c] == 1:
            return i

        i = i + 1

    return i

#
#
# Unit test class

class TestFirstUniqueCharacter(unittest.TestCase):
    def test_FirstUniqueCharacter(self):
        self.assertEqual(firstUniqueCharacter('Perl Weekly Challenge'), 0)
        self.assertEqual(firstUniqueCharacter('Long Live Perl'), 1)

unittest.main()

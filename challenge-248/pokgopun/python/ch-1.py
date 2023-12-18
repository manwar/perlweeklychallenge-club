### https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
"""

Task 1: Shortest Distance

Submitted by: [58]Mohammad S Anwar
     __________________________________________________________________

   You are given a string and a character in the given string.

   Write a script to return an array of integers of size same as length of
   the given string such that:
distance[i] is the distance from index i to the closest occurence of
the given character in the given string.

The distance between two indices i and j is abs(i - j).

Example 1

Input: $str = "loveleetcode", $char = "e"
Output: (3,2,1,0,1,0,0,1,2,2,1,0)

The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
The closest occurrence of 'e' for index 0 is at index 3, so the distance is abs(
0 - 3) = 3.
The closest occurrence of 'e' for index 1 is at index 3, so the distance is abs(
1 - 3) = 2.
For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
The closest occurrence of 'e' for index 8 is at index 6, so the distance is abs(
8 - 6) = 2.

Example 2

Input: $str = "aaab", $char = "b"
Output: (3,2,1,0)

Task 2: Submatrix Sum
"""
### solution by pokgopun@gmail.com

def shortestDistance(word, letter):
    l = len(word)
    letterIndexes = tuple( i for i in range(l) if word[i]==letter )
    return tuple(
            min( abs(x-i) for i in letterIndexes ) for x in range(l)
            )

import unittest

class TestShortestDistance(unittest.TestCase):
    def test(self):
        for (word,letter),distance in {
                ("loveleetcode", "e"): (3,2,1,0,1,0,0,1,2,2,1,0),
                ("aaab", "b"): (3,2,1,0),
                }.items():
            self.assertEqual(shortestDistance(word,letter),distance)

unittest.main()

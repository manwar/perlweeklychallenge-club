### https://theweeklychallenge.org/blog/perl-weekly-challenge-290/
"""

Task 1: Double Exist

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find if there exist two indices $i and $j such that:
1) $i != $j
2) 0 <= ($i, $j) < scalar @ints
3) $ints[$i] == 2 * $ints[$j]

Example 1

Input: @ints = (6, 2, 3, 3)
Output: true

For $i = 0, $j = 2
$ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

Example 2

Input: @ints = (3, 1, 4, 13)
Output: false

Example 3

Input: @ints = (2, 1, 4, 2)
Output: true

For $i = 2, $j = 3
$ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

Task 2: Luhn’s Algorithm
"""
### solution by pokgopun@gmail.com

def de(ints: tuple):
    #print(ints)
    l = len(ints)
    for i in range(l-1):
        for j in range(i+1,l):
            a, b = ints[i],ints[j]
            #print(a,b)
            if a == b:
                continue
            if max(a,b) == min(a,b) * 2:
                return True
    return False

import unittest

class TestDe(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (6, 2, 3, 3): True,
                (3, 1, 4, 13): False,
                (2, 1, 4, 2): True,
                }.items():
            self.assertEqual(de(inpt),otpt)

unittest.main()

### https://theweeklychallenge.org/blog/perl-weekly-challenge-314/
"""

Task 2: Sort Column

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of strings of same length.

   Write a script to make each column sorted lexicographically by deleting
   any non sorted columns.

   Return the total columns deleted.

Example 1

Input: @list = ("swpc", "tyad", "azbe")
Output: 2

swpc
tyad
azbe

Column 1: "s", "t", "a" => non sorted
Column 2: "w", "y", "z" => sorted
Column 3: "p", "a", "b" => non sorted
Column 4: "c", "d", "e" => sorted

Total columns to delete to make it sorted lexicographically.

Example 2

Input: @list = ("cba", "daf", "ghi")
Output: 1

Example 3

Input: @list = ("a", "b", "c")
Output: 0
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 30th March
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def sc(strings: tuple[str]) -> int:
    t = tuple(len(e) for e in strings)
    if len(set(t)) != 1:
        return -1
    l = t[0]
    c = len(strings)
    if c == 1:
        return 0
    count = 0
    string = strings[0]
    for i in range(l):
        p = string[i]
        for j in range(1,c):
            n = strings[j][i]
            if p > n:
                count += 1
                break
            p = n
    return count

import unittest

class TestSc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ("swpc", "tyad", "azbe"): 2,
                ("cba", "daf", "ghi"): 1,
                ("a", "b", "c"): 0,
                }.items():
            self.assertEqual(sc(inpt),otpt)

unittest.main()

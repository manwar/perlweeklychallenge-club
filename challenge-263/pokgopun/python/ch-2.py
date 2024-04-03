### https://theweeklychallenge.org/blog/perl-weekly-challenge-263/
"""

Task 2: Merge Items

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two 2-D array of positive integers, $items1 and $items2
   where element is pair of (item_id, item_quantity).

   Write a script to return the merged items.

Example 1

Input: $items1 = [ [1,1], [2,1], [3,2] ]
       $items2 = [ [2,2], [1,3] ]
Output: [ [1,4], [2,3], [3,2] ]

Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
Item id (3) appears 1 time: [3,2]

Example 2

Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
       $items2 = [ [3,1], [1,3] ]
Output: [ [1,8], [2,3], [3,3] ]

Example 3

Input: $items1 = [ [1,1], [2,2], [3,3] ]
       $items2 = [ [2,3], [2,4] ]
Output: [ [1,1], [2,9], [3,3] ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 7th April 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def mergeItems(items1, items2):
    dct = dict()
    for items in (items1, items2):
        for (k,v) in items:
            dct[k] = dct.setdefault(k,0) + v
    return tuple(dct.items())

import unittest

class TestMergeItems(unittest.TestCase):
    def test(self):
        for (items1, items2), merged in {
                (( (1,1), (2,1), (3,2) ), ( (2,2), (1,3) )): ( (1,4), (2,3), (3,2) ),
                (( (1,2), (2,3), (1,3), (3,2) ), ( (3,1), (1,3) )): ( (1,8), (2,3), (3,3) ),
                (( (1,1), (2,2), (3,3) ), ( (2,3), (2,4) )): ( (1,1), (2,9), (3,3) ),
                }.items():
            self.assertEqual(mergeItems(items1, items2),  merged)

unittest.main()

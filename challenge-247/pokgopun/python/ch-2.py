### https://theweeklychallenge.org/blog/perl-weekly-challenge-247/
"""

Task 2: Most Frequent Letter Pair

Submitted by: [55]Jorg Sommrey
     __________________________________________________________________

   You are given a string S of lower case letters 'a'..'z'.

   Write a script that finds the pair of consecutive letters in S that
   appears most frequently. If there is more than one such pair, chose the
   one that is the lexicographically first.

Example 1

Input: $s = 'abcdbca'
Output: 'bc'

'bc' appears twice in `$s`

Example 2

Input: $s = 'cdeabeabfcdfabgcd'
Output: 'ab'

'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically smalle
r than 'cd'.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def mflp(string: str):
    l = len(string)
    if l <= 2:
        return ""
    dct = dict()
    for i in range(l-1):
        pair = string[i:i+2]
        if dct.get(pair) is None:
            dct[pair] = 1
        else:
            dct[pair] += 1
    lst = list((-dct[x],x) for x in dct.keys())
    lst.sort()
    #print(lst)
    return lst[0][1]

import unittest

class TestMflp(unittest.TestCase):
    def test1(self):
        for inpt, otpt in {
                'abcdbca': 'bc',
                'cdeabeabfcdfabgcd': 'ab',
                }.items():
            self.assertEqual(mflp(inpt),otpt,f"error: most frequent letter pair of '{inpt}' must be '{otpt}'") 

unittest.main()

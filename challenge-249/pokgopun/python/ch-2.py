### https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
"""

Task 2: DI String Match

Submitted by: [67]Mohammad S Anwar
     __________________________________________________________________

   You are given a string s, consisting of only the characters "D" and
   "I".

   Find a permutation of the integers [0 .. length(s)] such that for each
   character s[i] in the string:
s[i] == 'I' ⇒ perm[i] < perm[i + 1]
s[i] == 'D' ⇒ perm[i] > perm[i + 1]

Example 1

Input: $str = "IDID"
Output: (0, 4, 1, 3, 2)

Example 2

Input: $str = "III"
Output: (0, 1, 2, 3)

Example 3

Input: $str = "DDI"
Output: (3, 2, 0, 1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 31st December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import permutations

def dism(s: str):
    t = tuple()
    l = len(s)
    for perm in permutations(tuple(range(l+1)),l+1):
        #print(perm)
        for i in range(l):
            #print(f"{s[i]},{perm[i]},{perm[i+1]}")
            if s[i]=="I":
                if perm[i] >= perm[i+1]:
                    break
            elif s[i]=="D":
                if perm[i] <= perm[i+1]:
                    break
        else:
            #print("=>",perm)
            t += (perm,)
    #print(t)
    return t

import unittest

class TestDism(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                "IDID": (0, 4, 1, 3, 2),
                "III": (0, 1, 2, 3),
                "DDI": (3, 2, 0, 1),
                }.items():
            self.assertEqual(dism(inpt).count(otpt)>0,True)

unittest.main()

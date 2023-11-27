### https://theweeklychallenge.org/blog/perl-weekly-challenge-245/
"""

Task 2: Largest of Three

Submitted by: [46]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers >= 0.

   Write a script to return the largest number formed by concatenating
   some of the given integers in any order which is also multiple of 3.
   Return -1 if none found.

Example 1

Input: @digits = (8, 1, 9)
Output: 981

981 % 3 == 0

Example 2

Input: @digits = (8, 6, 7, 1, 0)
Output: 8760

Example 3

Input: @digits = (1)
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 3rd December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import permutations

def lot(tup: tuple):
    for n in range(len(tup),0,-1):
        for x in permutations(
                sorted(tup,reverse=True), n
                ):
            y = int(
                    "".join( str(e) for e in x )
                    )
            if y % 3 == 0: return y
    return -1

for inpt, otpt in {
        (8, 1, 9): 981,
        (8, 6, 7, 1, 0): 8760,
        (1,): -1,
        }.items():
    print(otpt==lot(inpt))

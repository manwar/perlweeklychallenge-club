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

Input: @ints = (8, 1, 9)
Output: 981

981 % 3 == 0

Example 2

Input: @ints = (8, 6, 7, 1, 0)
Output: 8760

Example 3

Input: @ints = (1)
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 3rd December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import permutations, chain

def lot(tup: tuple):
    return max(
            chain.from_iterable(
                (
                    ( i for i in
                        (
                            int("".join(x)) for x in
                            (
                                (str(e) for e in y) for y in
                                chain.from_iterable(
                                    permutations(tup, n) for n in range(1,len(tup)+1)
                                    )
                                )
                            ) if i % 3 == 0
                        ),
                    (-1,),
                    )
                )
            )

for inpt, otpt in {
        (8, 1, 9): 981,
        (8, 6, 7, 1, 0): 8760,
        (1,): -1,
        (0,0,0): 0,
        (4, 8, 911): 9114,
        (8, 85, 0): 8850,
        (8, 89, 2): 8982,
        (8, 76, 0): 8760,
        (8, 94, 0): 9480,
        }.items():
    print(otpt==lot(inpt))

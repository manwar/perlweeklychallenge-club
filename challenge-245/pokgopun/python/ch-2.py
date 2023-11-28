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

def permutes(tup: tuple):
    for n in range(1,len(tup)+1):   ### need permutations(tup,n) loop instead of permutations(tup) alone to avoid a bug in itertools/permutations
        yield permutations(tup, n)

def intsOfThree(tup: tuple):
    for ints in chain.from_iterable(permutes(tup)):
        if sum(ints) % 3 == 0:   ### If a + b = c , then a ( mod N ) + b ( mod N ) ≡ c ( mod N )
            yield ints

def intOfThree(tup: tuple):
    for iStrs in  ((str(i) for i in ints) for ints in intsOfThree(tup)):   ### int-to-string conversion for ints so we can further concat and convert them to an int
        yield int("".join(iStrs))   ### concat and convert int strings to an int

def largestOfThree(tup: tuple):
    return max(   ### max() can avoid an error from null permute iterator as it operates on chain.from_iterables that include default (-1,)
            chain.from_iterable(
                (
                    intOfThree(tup),
                    (-1,)   ### add (-1,) to chain.from_iterable to avoid max() error from null iterator from permutations (i.e. when nothing qualifies sum % 3 == 0
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
    print(otpt==largestOfThree(inpt))

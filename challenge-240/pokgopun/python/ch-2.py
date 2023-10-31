### https://theweeklychallenge.org/blog/perl-weekly-challenge-240/
"""

Task 2: Build Array

Submitted by: [53]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to create an array such that new[i] = old[old[i]] where
   0 <= i < new.length.

Example 1

Input: @int = (0, 2, 1, 5, 3, 4)
Output: (0, 1, 2, 4, 5, 3)

Example 2

Input: @int = (5, 0, 1, 2, 3, 4)
Output: (4, 5, 0, 1, 2, 3)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 29th October
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def iSort(tup):
    return tuple(
            map( lambda x: tup[x], tup )
            )


for inpt,otpt in {
        (0, 2, 1, 5, 3, 4): (0, 1, 2, 4, 5, 3),
        (5, 0, 1, 2, 3, 4): (4, 5, 0, 1, 2, 3),
        }.items():
    print(iSort(inpt)==otpt)

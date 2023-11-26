### https://theweeklychallenge.org/blog/perl-weekly-challenge-241/
"""

Task 2: Prime Order

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of unique positive integers greater than 2.

   Write a script to sort them in ascending order of the count of their
   prime factors, tie-breaking by ascending value.

Example 1

Input: @int = (11, 8, 27, 4)
Output: (11, 4, 8, 27))

Prime factors of 11 => 11
Prime factors of  4 => 2, 2
Prime factors of  8 => 2, 2, 2
Prime factors of 27 => 3, 3, 3
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th November
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from sympy.ntheory import factorint

def sortByFactorCount(tup: tuple):
        return tuple(
                sorted(
                    sorted(tup), key = lambda x: sum(factorint(x).values())
                    )
                )

for inpt,otpt in {
        (11, 8, 27, 4): (11, 4, 8, 27),
        (11, 27, 8, 4): (11, 4, 8, 27),
        }.items():
    print(sortByFactorCount(inpt)==otpt)
 

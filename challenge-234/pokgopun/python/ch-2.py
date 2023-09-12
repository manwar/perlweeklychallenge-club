### https://theweeklychallenge.org/blog/perl-weekly-challenge-234/
"""

Task 2: Unequal Triplets

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of positive integers.

   Write a script to find the number of triplets (i, j, k) that satisfies
   num[i] != num[j], num[j] != num[k] and num[k] != num[i].

Example 1

Input: @ints = (4, 4, 2, 4, 3)
Ouput: 3

(0, 2, 4) because 4 != 2 != 3
(1, 2, 4) because 4 != 2 != 3
(2, 3, 4) because 2 != 4 != 3

Example 2

Input: @ints = (1, 1, 1, 1, 1)
Ouput: 0

Example 3

Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
Output: 28

triplets of 1, 4, 7  = 3x2×2 = 12 combinations
triplets of 1, 4, 10 = 3×2×1 = 6  combinations
triplets of 4, 7, 10 = 2×2×1 = 4  combinations
triplets of 1, 7, 10 = 3x2x1 = 6 combinations
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th September
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
from itertools import combinations

def utCount(tup):
    return len(
            tuple(
                filter(   ### set of unequal triplets will have 3 members
	                lambda x: x==3,
	                map(   ### then count set's member
	                    lambda x: len(x),
	                    map(  ### convert list of values to set to remove duplicated values
	                        lambda x: set(x),
	                        map(   ### map combo of index (i,j,k) to list of correspoing values
	                            lambda x: ( tup[i] for i in x ),
	                            combinations(range(len(tup)),3)
	                            )
	                        )
	                    )
	                )
	            )
            )
	
for inpt,otpt in {
        (4, 4, 2, 4, 3): 3,
        (1, 1, 1, 1, 1): 0,
        (4, 7, 1, 10, 7, 4, 1, 1): 28,
        }.items():
    print(utCount(inpt)==otpt)

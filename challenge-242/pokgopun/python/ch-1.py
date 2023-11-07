### https://theweeklychallenge.org/blog/perl-weekly-challenge-242/
"""

Task 1: Missing Members

Submitted by: [42]Mohammad S Anwar
     __________________________________________________________________

   You are given two arrays of integers.

   Write a script to find out the missing members in each other arrays.

Example 1

Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
(2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).

Example 2

Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they
are same, keep just one.
(1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).

Task 2: Flip Matrix
"""
### solution by pokgopun@gmail.com

def findMissing(tup1, tup2):
    return tuple(
            filter(lambda x: len(x) > 0,
                (
                    set(tup1).difference(set(tup2)),
                    set(tup2).difference(set(tup1)),
                    )
                )
            )



for (inpt1,inpt2),otpt in {
        ((1, 2, 3),(2, 4, 6)): ({1, 3}, {4, 6}),
        ((1, 2, 3, 3),(1, 1, 2, 2)): ({3},),
        }.items():
    print(findMissing(inpt1,inpt2)==otpt)




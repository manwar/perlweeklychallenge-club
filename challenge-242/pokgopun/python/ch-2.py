### https://theweeklychallenge.org/blog/perl-weekly-challenge-242/
"""

Task 2: Flip Matrix

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given n x n binary matrix.

   Write a script to flip the given matrix as below.
1 1 0
0 1 1
0 0 1

a) Reverse each row

0 1 1
1 1 0
1 0 0

b) Invert each member

1 0 0
0 0 1
0 1 1

Example 1

Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])

Example 2

Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 12th November
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def flipMatrix(tup):
    return tuple(
            map(lambda x: tuple( i ^ 1 for i in reversed(x)) , tup)
            )


for inpt,otpt in {
        ((1, 1, 0), (1, 0, 1), (0, 0, 0)): ((1, 0, 0), (0, 1, 0), (1, 1, 1)),
        ((1, 1, 0, 0), (1, 0, 0, 1), (0, 1, 1, 1), (1, 0, 1, 0)): ((1, 1, 0, 0), (0, 1, 1, 0), (0, 0, 0, 1), (1, 0, 1, 0)),
        }.items():
    print(flipMatrix(inpt)==otpt)

### https://theweeklychallenge.org/blog/perl-weekly-challenge-244/
"""

Task 1: Count Smaller

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to calculate the number of integers smaller than the
   integer at each index.

Example 1

Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.

Example 2

Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

Example 3

Input: @int = (2, 2, 2)
Output: (0, 0, 0)

Task 2: Group Hero
"""
### solution by pokgopun@gmail.com

def cltiConv(tup: tuple):
    return tuple(
            sum(1 if x < i else 0 for x in tup) for i in tup
            )

for inpt,otpt in {
        (8, 1, 2, 2, 3):(4, 0, 1, 1, 3),
        (6, 5, 4, 8):(2, 1, 0, 3),
        (2, 2, 2): (0, 0, 0),
        }.items():
    print(otpt==cltiConv(inpt))

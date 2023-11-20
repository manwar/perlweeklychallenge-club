### https://theweeklychallenge.org/blog/perl-weekly-challenge-243/
"""

Task 2: Floor Sum

Submitted by: [51]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of positive integers (>=1).

   Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <=
   i,j < nums.length. The floor() function returns the integer part of the
   division.

Example 1

Input: @nums = (2, 5, 9)
Output: 10

floor(2 / 5) = 0
floor(2 / 9) = 0
floor(5 / 9) = 0
floor(2 / 2) = 1
floor(5 / 5) = 1
floor(9 / 9) = 1
floor(5 / 2) = 2
floor(9 / 2) = 4
floor(9 / 5) = 1

Example 2

Input: @nums = (7, 7, 7, 7, 7, 7, 7)
Output: 49
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 19th November
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def floorSum(tup: tuple):
    c, l = 0, len(tup)
    for i in range(l):
        for j in range(l):
            c += tup[j]//tup[i]
    return c

for inpt,otpt in {
        (2, 5, 9): 10,
        (7, 7, 7, 7, 7, 7, 7): 49,
        }.items():
    print(floorSum(inpt)==otpt)

 

### https://theweeklychallenge.org/blog/perl-weekly-challenge-238/
"""

Task 1: Running Sum

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the running sum of the given array. The
   running sum can be calculated as sum[i] = num[0] + num[1] + …. +
   num[i].

Example 1

Input: @int = (1, 2, 3, 4, 5)
Output: (1, 3, 6, 10, 15)

Example 2

Input: @int = (1, 1, 1, 1, 1)
Output: (1, 2, 3, 4, 5)

Example 3

Input: @int = (0, -1, 1, 2)
Output: (0, -1, 0, 2)

Task 2: Persistence Sort
"""
### solution by pokgopun@gmail.com

def runningSum(tup):
    lst = list(tup)
    for i in range(1,len(lst)):
        lst[i] += lst[i-1]
    return tuple(lst)

for inpt, otpt in {
        (1, 2, 3, 4, 5):(1, 3, 6, 10, 15),
        (1, 1, 1, 1, 1):(1, 2, 3, 4, 5),
        (0, -1, 1, 2):(0, -1, 0, 2),
        }.items():
    print(runningSum(inpt)==otpt)

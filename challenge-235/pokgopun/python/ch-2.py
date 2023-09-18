### https://theweeklychallenge.org/blog/perl-weekly-challenge-235/
"""

Task 2: Duplicate Zeros

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to duplicate each occurrence of ZERO in the given array
   and shift the remaining to the right but make sure the size of array
   remain the same.

Example 1

Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Ouput: (1, 0, 0, 2, 3, 0, 0, 4)

Example 2

Input: @ints = (1, 2, 3)
Ouput: (1, 2, 3)

Example 3

Input: @ints = (0, 3, 0, 4, 5)
Ouput: (0, 0, 3, 0, 0)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 24th September
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def dupZero(tup):
    lst = list(tup)
    l = len(lst)
    i = 0
    while i < l:
        if lst[i]==0:
            lst.insert(i,0)
            i += 1
        i += 1
    return tuple(lst[:l])

for inpt,otpt in {
        (1, 0, 2, 3, 0, 4, 5, 0): (1, 0, 0, 2, 3, 0, 0, 4), 
        (1, 2, 3): (1, 2, 3),
        (0, 3, 0, 4, 5): (0, 0, 3, 0, 0),
        }.items():
    print(dupZero(inpt)==otpt)

 

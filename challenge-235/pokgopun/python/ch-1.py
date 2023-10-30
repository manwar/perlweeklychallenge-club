### https://theweeklychallenge.org/blog/perl-weekly-challenge-235/
"""

Task 1: Remove One

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to find out if removing ONLY one integer makes it
   strictly increasing order.

Example 1

Input: @ints = (0, 2, 9, 4, 6)
Output: true

Removing ONLY 9 in the given array makes it strictly increasing order.

Example 2

Input: @ints = (5, 1, 3, 2)
Output: false

Example 3

Input: @ints = (2, 2, 3)
Output: true

Task 2: Duplicate Zeros
"""
### solution by pokgopun@gmail.com

def isRmoSorted(lst):
    l = len(lst)
    for i in range(l):
        v = None
        isSorted = True
        for j in range(l):
            if j == i: continue
            if v != None:
                #print(v,j)
                if lst[v] > lst[j]:
                    isSorted = False
                    break
            v = j
        if isSorted == True: return True
    return False

for inpt,otpt in {
        (0, 2, 9, 4, 6): True,
        (5, 1, 3, 2): False,
        (2, 2, 3): True,
        }.items():
    print(isRmoSorted(inpt)==otpt)

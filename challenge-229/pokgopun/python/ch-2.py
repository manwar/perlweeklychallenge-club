# https://theweeklychallenge.org/blog/perl-weekly-challenge-229/
"""
Task 2: Two out of Three
Submitted by: Mohammad S Anwar
You are given three array of integers.

Write a script to return all the elements that are present in at least 2 out of 3 given arrays.

Example 1
Input: @array1 = (1, 1, 2, 4)
       @array2 = (2, 4)
       @array3 = (4)
Ouput: (2, 4)
Example 2
Input: @array1 = (4, 1)
       @array2 = (2, 4)
       @array3 = (1, 2)
Ouput: (1, 2, 4)
"""

def elemsFromLsts (*lsts):
    for lst in lsts:
        for elem in set(lst):
            yield elem

def dupElemLst(*lsts):
    lst = [ x for x in elemsFromLsts(*lsts) ]
    return list(filter(lambda x: lst.count(x) > 1, set(lst)))

assert set(dupElemLst([1,1,2,4],[2,4],[4]))=={2,4}
assert set(dupElemLst([4,1],[2,4],[1,2]))=={1,2,4}

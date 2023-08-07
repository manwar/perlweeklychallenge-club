# https://theweeklychallenge.org/blog/perl-weekly-challenge-229/
"""
Task 1: Lexicographic Order
Submitted by: Mohammad S Anwar
You are given an array of strings.

Write a script to delete element which is not lexicographically sorted (forwards or backwards) and return the count of deletions.

Example 1
Input: @str = ("abc", "bce", "cae")
Output: 1

In the given array "cae" is the only element which is not lexicographically sorted.
Example 2
Input: @str = ("yxz", "cba", "mon")
Output: 2

In the given array "yxz" and "mon" are not lexicographically sorted.
"""

def delUnsortedElem(lst):
    cnt = 0
    for elem in lst:
        if elem not in ("".join(sorted(list(elem))), "".join(sorted(list(elem),reverse=True))):
            lst.remove(elem)
            cnt += 1
    return cnt

assert delUnsortedElem(["abc", "bce", "cae"])==1
assert delUnsortedElem(["yxz", "cba", "mon"])==2

# https://theweeklychallenge.org/blog/perl-weekly-challenge-230/
"""
Task 1: Separate Digits
Submitted by: Mohammad S Anwar
You are given an array of positive integers.

Write a script to separate the given array into single digits.

Example 1
Input: @ints = (1, 34, 5, 6)
Output: (1, 3, 4, 5, 6)
Example 2
Input: @ints = (1, 24, 51, 60)
Output: (1, 2, 4, 5, 1, 6, 0)

"""
def intTupTodigTup(itup):
    dlst = []
    for i in itup:
        for cp in bytes(str(i),"ascii"): # convert int to str, then convert str to list of codepoint
            dlst.append(int(chr(cp))) # convert codepoint to str, then str to int, and append it to array
    return tuple(dlst)

for ipt,opt in ( # use tuple instead of list so we can simply copy and past sample data
        ((1, 34, 5, 6), (1, 3, 4, 5, 6)),
        ((1, 24, 51, 60), (1, 2, 4, 5, 1, 6, 0))
        ):
    print(intTupTodigTup(ipt)==opt)




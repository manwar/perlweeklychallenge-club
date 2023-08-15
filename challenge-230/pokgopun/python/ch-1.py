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
### function solution

def intToDigLst(i):
    lst = []
    while i // 10 > 0:
        lst.insert(0, i % 10)
        i //= 10
    lst.insert(0,i)
    return lst
"""
for i in (480,8080,8089):
    print(i,intToDigLst(i))
"""
def intLstToDigLst(lst):
    dlst = []
    for i in lst:
        dlst += intToDigLst(i)
    return dlst

for ipt,opt in ( 
        ([1, 34, 5, 6], [1, 3, 4, 5, 6]),
        ([1, 24, 51, 60], [1, 2, 4, 5, 1, 6, 0])
        ):
    print(intLstToDigLst(ipt)==opt)
    #print(ipt,intLstToDigLst(ipt))

### generator solution
def digFromInt(i): # output need to be reversed
    while i // 10 > 0:
        yield i % 10
        i //= 10
    yield i
"""
for i in (480,8080,8089):
    print(i,[ d for d in digFromInt(i)])
"""
def digFromIntLst(lst):
    for i in lst:
        for d in reversed([ d for d in digFromInt(i)]): # reserved() function work with iterable but not generator, need list comprehension
            yield d
for ipt,opt in ( 
        ([1, 34, 5, 6], [1, 3, 4, 5, 6]),
        ([1, 24, 51, 60], [1, 2, 4, 5, 1, 6, 0])
        ):
    print([ d for d in digFromIntLst(ipt)]==opt)

### class solution, __iter__ to call generator method, basically put generator solution into a class
class DigFromIntLst():
    def __init__(self,lst):
        self.lst = lst
        self.i = 0
    def generator(self,i):
        while i // 10 > 0:
            yield i % 10
            i //= 10
        yield i
    def __iter__(self):
        for i in self.lst:
            for d in reversed([ d for d in self.generator(i)]):
                yield d

for ipt,opt in ( 
        ([1, 34, 5, 6], [1, 3, 4, 5, 6]),
        ([1, 24, 51, 60], [1, 2, 4, 5, 1, 6, 0])
        ):
    print([ d for d in DigFromIntLst(ipt)]==opt)


### lazy solution - use converting type to/from int/str/bytes

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


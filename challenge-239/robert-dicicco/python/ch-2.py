#!/usr/bin/env python
'''
---------------------------------------
AUTHOR : Robert DiCicco
DATE   : 2023-10-22
Challenge 239 Task 02 Consistent Strings ( Python )
--------------------------------------
'''


mystr = [["ad", "bd", "aaab", "baa", "badab", "ab"],
              ["a", "b", "c", "ab", "ac", "bc", "abc","abc"],
              ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d","cad"]]
cnt = 0

def CheckConsistent(str, mallow) :
    total = 0
    i = 0
    while (i < len(str) - 1):
        S = set([*str[i]])
        M = set([*mallow])
        df = (S - M)
        if len(df) == 0:
            total += 1
        i += 1
    return total

while cnt < len(mystr) :
    ln = len(mystr[cnt])
    print(f"Input: @str = {mystr[cnt][0:ln-1]}")
    print(f"Allowed = {mystr[cnt][-1]}")
    mallow = mystr[cnt][-1]
    retval = CheckConsistent(mystr[cnt], mallow)
    print(f"Output: {retval}\n")
    cnt += 1

'''
---------------------------------------
SAMPLE OUTPUT

python .\Consistent.py

Input: @str = ['ad', 'bd', 'aaab', 'baa', 'badab']
Allowed = ab
Output: 2

Input: @str = ['a', 'b', 'c', 'ab', 'ac', 'bc', 'abc']
Allowed = abc
Output: 7

Input: @str = ['cc', 'acd', 'b', 'ba', 'bac', 'bad', 'ac', 'd']
Allowed = cad
Output: 4
--------------------------------------
'''



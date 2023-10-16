#!/usr/bin/env python
'''
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-16
Challenge 239 Task 01 Same String ( Python )
------------------------------------
'''

myarr1 = [["ab", "c"],["ab", "c"],["ab", "cd", "e"]]
myarr2 = [["a", "bc"],["ac", "b"],["abcde"]]

cnt = 0

while cnt < len(myarr1):
    print(f"Input:  @arr1 = {myarr1[cnt]}")
    print(f"\t@arr2 = {myarr2[cnt]}")
    if "".join(myarr1[cnt]) == "".join(myarr2[cnt]):
        print("Output: true\n")
    else:
        print("Output: false\n")

    cnt += 1

'''
-------------------------------------
SAMPLE OUTPUT

python .\SameString.py

Input:  @arr1 = ['ab', 'c']
        @arr2 = ['a', 'bc']
Output: true

Input:  @arr1 = ['ab', 'c']
        @arr2 = ['ac', 'b']
Output: false

Input:  @arr1 = ['ab', 'cd', 'e']
        @arr2 = ['abcde']
Output: true
------------------------------------
'''




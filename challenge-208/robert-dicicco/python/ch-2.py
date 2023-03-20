#!/usr/bin/env python
'''
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-15
Challenge 208 'Duplicate and Missing' ( Python )
----------------------------------------------
'''
nums = [[1,2,2,4],[1,2,3,4],[1,2,3,3]]

for a in nums:
    found = 0
    print("Input: @nums = ",a)
    ln = len(a)
    for n in range(ln):
        if a[n] != n+1:
            print("Output: (",a[n],',',n+1,")\n")
            found = 1
    if found == 0:
        print("Output: -1\n")
'''
----------------------------------------------
SAMPLE OUTPUT
python .\DupMissing.py
Input: @nums =  [1, 2, 2, 4]
Output: ( 2 , 3 )

Input: @nums =  [1, 2, 3, 4]
Output: -1

Input: @nums =  [1, 2, 3, 3]
Output: ( 3 , 4 )
----------------------------------------------
'''

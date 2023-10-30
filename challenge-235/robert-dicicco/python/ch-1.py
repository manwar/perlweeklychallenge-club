#!/usr/bin/env python
'''
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-18
Challenge 235 Task 1 Remove One ( Python )
---------------------------------------
'''

myints = [[0, 2, 9, 4, 6],[5, 1, 3, 2],[2, 2, 3]]

for mints in myints:
    print(f"Input: @ints = {mints}")
    ln = len(mints)
    cnt = 0
    x = 1
    while x < ln:
        if mints[x] > mints[x-1]:
            print(f"\t{mints[x]} greater than {mints[x-1]}")
            x += 1
        elif mints[x] == mints[x-1]:
            print(f"\t{mints[x]} equal to {mints[x-1]}")
            x += 1
            cnt += 1
        else :
            print(f"\t{mints[x]} less than {mints[x-1]}")
            x += 1
            cnt += 1
    if cnt == 1:
        print("Output: true\n")
    else:
        print("Output: false\n")

'''
---------------------------------------
SAMPLE OUTPUT
python .\RemoveOne.py

Input: @ints = [0, 2, 9, 4, 6]
        2 greater than 0
        9 greater than 2
        4 less than 9
        6 greater than 4
Output: true

Input: @ints = [5, 1, 3, 2]
        1 less than 5
        3 greater than 1
        2 less than 3
Output: false

Input: @ints = [2, 2, 3]
        2 equal to 2
        3 greater than 2
Output: true
---------------------------------------
'''



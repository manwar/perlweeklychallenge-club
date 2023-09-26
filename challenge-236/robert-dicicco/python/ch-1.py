#!/usr/bin/env python
'''
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-25
Challenge 236 Task 01 Exact Change ( Python )
-------------------------------------
'''
bills = [[5, 5, 5, 10, 20], [5, 5, 10, 10, 20],[5, 5, 5, 20]]

for paid in bills:
    print(f"Input: @bills = {paid}")
    cnt = 0
    change = 0
    while cnt < len(paid):
        ticket = paid[cnt]
        change_required = ticket - 5
        if ticket == 5:
            change += 5
        elif ticket == 10:
            change += 0
        elif ticket == 20:
            if change_required > change:
                print("Output: false\n")
                break
            else:
                print("Output: true\n")
                break
            change -= 10
        cnt += 1

'''
--------------------------------------
SAMPLE OUTPUT
python .\ExactChange.py

Input: @bills = [5, 5, 5, 10, 20]
Output: true

Input: @bills = [5, 5, 10, 10, 20]
Output: false

Input: @bills = [5, 5, 5, 20]
Output: true
-------------------------------------
'''





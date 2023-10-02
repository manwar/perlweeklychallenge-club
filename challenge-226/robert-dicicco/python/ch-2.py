#!/usr/bin/env python
'''
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-20
Challenge 226 Task 2 Zero Array ( Python )
--------------------------------------
'''

ints = [[1, 5, 0, 3, 5],[0],[2, 1, 4, 0, 3]]
flag = 1

def GetMinint(x):
    cnt = 0
    minint = 100
    while cnt < len(x):
        if  x[cnt] > 0 and x[cnt] < minint:
            minint = x[cnt]
        cnt += 1
    return minint

cycle = 1
for nts in ints:
    while flag == 1:
        if (cycle == 1):
            print(f"Input: ints = {nts}")

        cnt = 0

        if len(nts) == 1 and nts[0] == 0 :
             break

        #### find min of array ( not including zero )
        minint = GetMinint(nts)

        cnt = 0
        while cnt < len(nts):
            if nts[cnt] > 0 :
                nts[cnt] -= minint

            cnt += 1


        print(f"operation cycle: pick {minint} {nts}")
        cycle +=1

        cnt = 0
        flag = 0
        while  cnt < len(nts) :
            if (nts[cnt] > 0) :
                flag = 1

            cnt += 1


    cycle -= 1
    print(f"Output: {cycle}\n")
    flag = 1
    cycle = 1

'''
--------------------------------------
SAMPLE OUTPUT
python .\ZeroArray.py
Input: ints = [1, 5, 0, 3, 5]
operation cycle: pick 1 [0, 4, 0, 2, 4]
operation cycle: pick 2 [0, 2, 0, 0, 2]
operation cycle: pick 2 [0, 0, 0, 0, 0]
Output: 3

Input: ints = [0]
Output: 0

Input: ints = [2, 1, 4, 0, 3]
operation cycle: pick 1 [1, 0, 3, 0, 2]
operation cycle: pick 1 [0, 0, 2, 0, 1]
operation cycle: pick 1 [0, 0, 1, 0, 0]
operation cycle: pick 1 [0, 0, 0, 0, 0]
Output: 4
--------------------------------------
'''




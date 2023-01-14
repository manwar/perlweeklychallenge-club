#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE  : 2023-01-14

Challenge 199 Good Triplets ( Python )

'''

from itertools import combinations

 

list1 = [3,0,1,1,9,7]

x = 7

y = 2

z = 3

 

seen = {}

 

for res in (list(combinations(list1, 3))):

    if res in seen:

        continue

    else:

        x1 = list1.index(res[0])

        x2 = list1.index(res[1])

        x3 = list1.index(res[2])

        if x1 > x2 or x2 > x3 or x1 > x3:

            continue

        else:

            if abs(res[0] - res[1]) > x or abs(res[1] - res[2]) > y or abs(res[0] - res[2]) > z :

                continue

            else:

                print(res)

        seen[res] = 1

       

'''

SAMPLE OUTPUT

python .\GoodTriplets.py

(3, 0, 1)

(3, 1, 1)

(0, 1, 1)

'''

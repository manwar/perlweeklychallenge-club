#!python3

import numpy as np
import sys

# python ch-2.py "[ 10, 4, 1, 8, 12, 3 ][ 0, 2, 5 ]"

assert len(sys.argv) == 2

arr1 = np.empty(0, int)
arr2 = np.empty(0, int)
arr = np.array(sys.argv[1].replace('[', '').replace(' ', '').split(']'))

arr1 = arr[0].split(',')
arr2 = arr[1].split(',')

arr_sort = np.empty(0, int)

for key in arr2:
    arr_sort = np.append(arr_sort, int(arr1[int(key)]))

arr_sort = np.sort(arr_sort)

i = -1
for key in arr2:
    i += 1
    arr1[int(key)] = arr_sort[i]

print(arr1)
